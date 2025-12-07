import 'package:da_kanji_mobile/core/supabase/controller/supabase_auth.dart';
import 'package:da_kanji_mobile/core/supabase/controller/supabase_user_profile.dart';
import 'package:da_kanji_mobile/core/supabase/model/user_profile.dart';
import 'package:da_kanji_mobile/core/widgets/color_picker_dialog.dart';
import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_loading_indicator.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/user_icon.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



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

  late Future<bool> _initAsyncFuture;

  late Color currentColor;

  final _usernameController = TextEditingController();

  final _characterController = TextEditingController();

  var _loading = false;

  @override
  void initState() {
    super.initState();
    _initAsyncFuture = initAsync();
  }

  Future<bool> initAsync() async {
    final profile = await supabaseGetProfile(context);
    if (profile != null) {
      currentColor = profile.avatarColor;
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 48),
              Text(LocaleKeys.HomeScreen_account_page_error_loading.tr()),
            ],
          );

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserIcon(currentColor),
        
                    Positioned(
                      right: -16,
                      bottom: -16,
                      child: IconButton(
                        icon: Icon(Icons.colorize_outlined),
                        onPressed: () async { 
                          final newColor = await showColorPickerDialog(context, currentColor);
                          if (newColor != null) {
                            setState(() => currentColor = newColor);
                          }
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: TextFormField(
                    controller: _characterController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.HomeScreen_account_page_your_character.tr(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.HomeScreen_account_page_user_name.tr()
              ),
            ),
            const SizedBox(height: 18),
            
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _loading ? null : _updateProfile,
              child: Text(_loading
                ? LocaleKeys.HomeScreen_account_page_saving.tr()
                : LocaleKeys.HomeScreen_account_page_update.tr()
              ),
            ),
            Divider(),
            const SizedBox(height: 18),
            Text(
              LocaleKeys.HomeScreen_account_page_link_with.tr(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                'GitHub: ${LocaleKeys.HomeScreen_acount_page_not_linked.tr()}'
              ),
              trailing: IconButton(
                onPressed: () {
                  //TODO
                },
                icon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 18),
            Divider(),
            TextButton(
              onPressed: _signOut,
              child: Text(LocaleKeys.HomeScreen_account_page_sign_out.tr())
            ),
          ],
        );
      }
    );
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    await supabaseUpdateProfile(
      UserProfile(
        avatarColor: currentColor,
        avatarCharacter: _characterController.text,
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

