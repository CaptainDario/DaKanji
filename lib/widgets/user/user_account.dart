import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';



class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage("assets/images/dakanji/icon.png"),
      onLogin: (p0) async {
        return "";
      },
      onRecoverPassword: (p0) async {
        return "";
      },
    );
  }
}