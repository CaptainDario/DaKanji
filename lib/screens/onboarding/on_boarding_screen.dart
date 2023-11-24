// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:vector_graphics/vector_graphics.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/screens.dart';
import 'package:da_kanji_mobile/domain/user_data/user_data.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:da_kanji_mobile/screens/dictionary/dictionary_screen.dart';
import 'package:da_kanji_mobile/widgets/onboarding/on_boarding_page.dart';

/// The "home"-screen
/// 
/// If this is the first app start or a new feature was added shows the
/// onBoarding
/// If a new version was installed shows a popup with the CHANGELOG of this 
/// version. 
/// Otherwise navigates to the "draw"-screen.
class OnBoardingScreen extends StatefulWidget {

  const OnBoardingScreen(
    {
      Key? key
    }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
  with TickerProviderStateMixin {

  // --- NEEDS TO BE UPDATED FOR NEW PAGES -------------------------------------
  /// total number of onboarding pages (excluding the final drawing screen)
  int totalPages = 4;
  /// background colors for the pages
  List<Color> pageColors = [
      g_Dakanji_red,
      g_Dakanji_grey,
      g_Dakanji_green,
      g_Dakanji_blue
    ];
  /// The texts that should be shown on each onboarding page
  List onboardingPageTexts = [
    LocaleKeys.OnBoarding_Onboarding_1_title.tr(), LocaleKeys.OnBoarding_Onboarding_1_text.tr(),
    LocaleKeys.OnBoarding_Onboarding_2_title.tr(), LocaleKeys.OnBoarding_Onboarding_2_text.tr(),
    LocaleKeys.OnBoarding_Onboarding_3_title.tr(), LocaleKeys.OnBoarding_Onboarding_3_text.tr(),
    LocaleKeys.OnBoarding_Onboarding_4_title.tr(), LocaleKeys.OnBoarding_Onboarding_4_text.tr(),
  ];
  //----------------------------------------------------------------------------

  /// the size of the blob to indicate that the page can be turned by swiping
  double blobSize = 75.0;
  /// the height of the buttons to advance the onboaridng
  double buttonHeight = 50.0;
  /// the controller to progress the liquid swipe
  LiquidController liquidController = LiquidController();
  /// the controller to animate the onboarding pictures
  late final AnimationController _swipeController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this
  );
  /// controller for the movemnet of the liquid swipe dragger
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  /// animation for the movemnet of the liquid swipe dragger
  late final Animation scaleAnimation;
  /// Svg vector data preloaded to prevent stuttering
  List<ui.Image> svgImages = [];
  /// Is the user currently dragging the liquid swipe onboarding
  bool isDragging = true;


  @override
  void initState() { 
    super.initState();
    
    scaleAnimation = Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut
    ));
    _controller.repeat(reverse: true);

    _controller.addListener(updateDraggerSize);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init().then((value) => setState((){}));
    });
  }

  Future<void> init() async {
    for (var i = 1; i <= totalPages; i++) {
      for (var j = 1; j <= 2; j++) {
        AssetBytesLoader aBL = AssetBytesLoader(
          'assets/images/onboarding/onboarding_${i}_$j.vec'
        );
        PictureInfo pI = await vg.loadPicture(aBL, context);
        svgImages.add(pI.picture.toImageSync(3000, 3000));
      }
    }
  }

  @override
  void dispose(){
    liquidController.provider?.removeListener(updateDraggerSize);
    _controller.dispose();
    super.dispose();
  }

  void updateDraggerSize(){
    liquidController.provider?.setIconSize(Size(scaleAnimation.value*15, 50));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          
          if(svgImages.length < totalPages*2) return const SizedBox();

          return LiquidSwipe(
            positionSlideIcon: 0.85,           
            enableSideReveal: true,
            liquidController: liquidController,
            fullTransitionValue: 600,
            enableLoop: false,
            slideIconWidget: const SizedBox(
              width:  15, 
              height: 15,
            ),
            slidePercentCallback: (slidePercentHorizontal, slidePercentVertical) {
              if(liquidController.provider == null) return;

              if(isDragging){
                _swipeController.value = liquidController.provider!.slidePercentHor;
              }
            },
            currentUpdateTypeCallback: (updateType) {
              if(liquidController.provider == null) return;

              if(updateType == UpdateType.doneDragging){
                isDragging = false;
                if(liquidController.provider!.slidePercentHor < 0.2){
                  _swipeController.reverse();
                }
                else{
                  _swipeController.forward();
                }
              }
              else if(updateType == UpdateType.dragging){
                isDragging = true;
              }
            },
            onPageChangeCallback: (int activePageIndex) {
              if(liquidController.provider!.activePageIndex != activePageIndex){
                _swipeController.value = 0;
              }
              // change the current route to the drawing screen
              if (activePageIndex == totalPages){
                GetIt.I<UserData>().showOnboarding = false;
                GetIt.I<UserData>().save();
                Future.delayed(const Duration(milliseconds: 500), () =>
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/${Screens.dictionary.name}",
                    (route) => false
                  )
                );
              }
            },
            pages: [
              for (int i = 0; i < totalPages; i++)
                OnBoardingPage(
                  i+1,
                  svgImages[(i*2)], svgImages[i*2+1],
                  totalPages,
                  pageColors[i],
                  onboardingPageTexts[(i*2)], onboardingPageTexts[(i*2)+1],
                  liquidController,
                  _swipeController
                ),
              const DictionaryScreen(false, false, ""),
            ],
          );
        }
      ),
    );
  }

}

