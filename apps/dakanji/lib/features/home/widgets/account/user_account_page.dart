import 'package:da_kanji_mobile/core/supabase/controller/sponsor_oauth.dart';
import 'package:da_kanji_mobile/core/supabase/controller/supabase_auth.dart';
import 'package:da_kanji_mobile/core/supabase/controller/supabase_user_profile.dart';
import 'package:da_kanji_mobile/core/supabase/model/supabase_cache_manager.dart';
import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';
import 'package:da_kanji_mobile/core/widgets/color_picker_dialog.dart';
import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_loading_indicator.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/link_to_sponsor_card.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/user_icon_editor.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



class UserAccountPage extends StatefulWidget {


  const UserAccountPage(
    {
      super.key
    }
  );

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {

  /// Initialization Future (get data from Supabase)
  late Future<bool> _initAsyncFuture;

  /// The Key for the input form
  final formKey = GlobalKey<FormState>();

  
  final _usernameController = TextEditingController();

  final _characterController = TextEditingController();

  /// Current selected color
  late Color currentAvatarColor;
  /// Current selected avatar text color
  late Color currentAvatarCharacterColor;
  /// Loading state
  var _loading = false;

  @override
  void initState() {
    super.initState();
    _initAsyncFuture = initAsync();
  }

  Future<bool> initAsync() async {
    final profile = await supabaseGetProfile(context);
    if (profile != null) {
      currentAvatarColor = profile.avatarColor;
      currentAvatarCharacterColor = profile.avatarCharacterColor;
      _usernameController.text  = profile.username;
      _characterController.text = profile.avatarCharacter;
      return true;
    }
    else {
      return false;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _characterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initAsyncFuture,
      builder: (context, asyncSnapshot) {

        // still loading
        if(!asyncSnapshot.hasData) return const Center(child: DaKanjiLoadingIndicator());

        // no data / error
        if(asyncSnapshot.hasError || !asyncSnapshot.data!)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 48),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    LocaleKeys.HomeScreen_account_page_error_loading.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );

        return Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            children: [
              Row(
                children: [
                  SizedBox(width: 18,),
                  Center(
                    child: UserIconEditor(
                      width: 96,
                      height: 96,
                      avatarColor: currentAvatarColor,
                      avatarCharacter: _characterController.text.isNotEmpty
                        ? _characterController.text.substring(0, 1)
                        : "?",
                      avatarCharacterColor: currentAvatarCharacterColor,
                      onAvatarColorPickerPressed: () async { 
                        final newColor = await showColorPickerDialog(context, currentAvatarColor);
                        if (newColor != null) {
                          setState(() => currentAvatarColor = newColor);
                        }
                      },
                      onAvatarCharacterColorPickerPressed: () async { 
                        final newColor = await showColorPickerDialog(context, currentAvatarCharacterColor);
                        if (newColor != null) {
                          setState(() => currentAvatarCharacterColor = newColor);
                        }
                      },
                      
                    )
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Japanse character input
                        TextFormField(
                          controller: _characterController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.HomeScreen_account_page_your_character.tr(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.runes.length != 1) {
                              return LocaleKeys.HomeScreen_account_page_char_input_error.tr();
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 12),
                        // Username input
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.HomeScreen_account_page_user_name.tr()
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length > 10) {
                              return LocaleKeys.HomeScreen_account_page_user_name_input_error.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              Text(
                LocaleKeys.HomeScreen_account_page_link_to_sponsor.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 18),
              LinkToSponsorCard(
                sponsorIcon: Icons.account_circle_outlined,
                sponsor: "GitHub",
                sponsorStatus: LocaleKeys.HomeScreen_acount_page_not_linked.tr() +
                  context.read<SupabaseCacheManager>().userProfile.sponsorships.isGithubSponsor.toString(),
                onTap: () async {
                  final handler = OAuthLinkerService(
                    cacheManager: context.read<SupabaseCacheManager>(),
                  );

                  try{
                    await handler.linkProvider(OAuthProvider.github);
                  } 
                  on PlatformException catch (e) {
                    if (e.code == 'CANCELED') {
                      debugPrint('User canceled the login flow.');
                    } else {
                      debugPrint('Platform error during auth: ${e.message}');
                    }
                  }
                  catch (e) {
                    debugPrint('An unexpected error occurred during webauth: $e');
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.error
                      )
                    ),
                    onPressed: _signOut,
                    child: Text(LocaleKeys.HomeScreen_account_page_sign_out.tr())
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.white
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        g_Dakanji_green
                      ),
                    ),
                    onPressed: _loading ? null : _updateProfile,
                    child: Text(_loading
                      ? LocaleKeys.HomeScreen_account_page_saving.tr()
                      : LocaleKeys.HomeScreen_account_page_update.tr()
                    ),
                  ),
                ]
              ),
            ],
          ),
        );
      }
    );
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {

    // Check if the user input is valid
    if (!formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    await supabaseUpdateProfile(
      UserProfile(
        avatarColor: currentAvatarColor,
        avatarCharacter: _characterController.text,
        avatarCharacterColor: currentAvatarCharacterColor,
        username: _usernameController.text,
      ),
      context,
    );

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _signOut() async {

    await signOut(context);

  }

}

