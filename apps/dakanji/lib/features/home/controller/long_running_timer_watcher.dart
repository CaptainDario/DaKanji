import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Adjust import path as needed for your project structure
import 'package:da_kanji_mobile/core/user/time_tracking/time_tracking_dao.dart';

class TimeTrackingNotificationService {
  static final TimeTrackingNotificationService _instance = TimeTrackingNotificationService._internal();
  factory TimeTrackingNotificationService() => _instance;
  TimeTrackingNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  // Constants for clean usage
  static const String _timerCategory = 'long_running_timer_category';
  static const String _actionOpen = 'action_open_app';

  /// Setup the plugin but DO NOT ask for permissions yet.
  Future<void> initialize() async {
    if (_isInitialized) return;

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // --- MACOS/IOS ACTION SETUP ---
    final List<DarwinNotificationCategory> darwinNotificationCategories = [
      DarwinNotificationCategory(
        _timerCategory,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain(
            _actionOpen,
            'Open App',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      notificationCategories: darwinNotificationCategories,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.actionId == _actionOpen) {
           // App is brought to foreground automatically by the option above.
        }
      },
    );

    _isInitialized = true;
    debugPrint("TimeTrackingNotificationService: Initialized");
  }

  /// Trigger the system permission dialog.
  Future<bool> requestPermissions() async {
    // Ensure we are initialized before asking
    await initialize();
    
    debugPrint("TimeTrackingNotificationService: Requesting Permissions...");

    if (kIsWeb) return false;

    if (Platform.isAndroid) {
      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestNotificationsPermission();
      return granted ?? false;
    } 
    
    if (Platform.isIOS) {
      final bool? granted = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return granted ?? false;
    }

    if (Platform.isMacOS) {
      final macPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>();
      
      if (macPlugin == null) {
        debugPrint("TimeTrackingNotificationService ERROR: MacOS plugin implementation not found.");
        return false;
      }

      final bool? granted = await macPlugin.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      
      debugPrint("TimeTrackingNotificationService: MacOS Granted? $granted");
      return granted ?? false;
    }

    return false;
  }

  /// Sends the specific "Abandoned Session" alert.
  Future<void> showTimeoutNotification(DateTime startTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'timer_alerts',
      'Timer Alerts',
      channelDescription: 'Notifications for long running study timers',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      actions: [
        AndroidNotificationAction(_actionOpen, 'Open App'),
      ],
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentSound: true,
      presentBanner: true,
      presentList: true,
      categoryIdentifier: _timerCategory, 
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      id: 0,
      title: 'Still Studying?',
      body: 'Your session has been running for over 6 hours.',
      notificationDetails: platformChannelSpecifics,
    );
  }
}

/// Mixin to monitor for abandoned sessions.
mixin LongRunningTimerWatcher<T extends StatefulWidget> on State<T> implements WidgetsBindingObserver {
  
  TimeTrackingDao get dao; 
  Timer? _activePollingTimer;
  
  AppLifecycleState _lifecycleState = AppLifecycleState.resumed;
  bool _hasNotifiedThisSession = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize the service (Safe to call multiple times)
    TimeTrackingNotificationService().initialize();
    
    _checkTimer();

    _activePollingTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      _checkTimer();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _activePollingTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleState = state;
    if (state == AppLifecycleState.resumed) {
      _checkTimer();
    }
  }

  Future<void> _checkTimer() async {
    final startTime = await dao.checkLongRunningTimer(thresholdHours: 6);
    
    if (startTime == null) {
      _hasNotifiedThisSession = false;
      return;
    }

    if (_lifecycleState == AppLifecycleState.resumed && mounted) {
      _showAbandonedSessionDialog(startTime);
      return; 
    }

    if (!_hasNotifiedThisSession) {
      await TimeTrackingNotificationService().showTimeoutNotification(startTime);
      _hasNotifiedThisSession = true;
    }
  }

  void _showAbandonedSessionDialog(DateTime startTime) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Still Studying?"),
        content: Text(
          "You have a session running since ${startTime.hour}:${startTime.minute}.\n"
          "It has been over 6 hours. Do you want to keep it?"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Fix End Time"),
          ),
          FilledButton(
            onPressed: () {
               dao.finishSession(); 
               Navigator.of(context).pop();
            },
            child: const Text("Stop Now"),
          ),
        ],
      ),
    );
  }
}