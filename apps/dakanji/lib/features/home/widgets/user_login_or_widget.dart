import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';




/// Either shows a login screen if the user is not authenticated
/// or the given widget
class UserLoginOrWidget extends StatefulWidget {
  const UserLoginOrWidget({super.key});

  @override
  State<UserLoginOrWidget> createState() => _UserLoginOrWidgetState();
}

class _UserLoginOrWidgetState extends State<UserLoginOrWidget> {

  @override
  Widget build(BuildContext context) {

    return FlutterLogin(
      theme: LoginTheme(
        cardTheme: CardTheme(
          color: Colors.blueGrey.withAlpha(25),
        )
      ),
      logo: const AssetImage("assets/images/dakanji/icon.png"),
      onLogin: (p0) async {
      },
      passwordValidator: validatePassword,
      onRecoverPassword: (p0) {
        
      },
      onSignup: _signupUser,
      onConfirmSignup: _verifyOtp,
    );
  }

  Future<String?> _loginUser(LoginData data) async {
    try {
      final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
        email: data.name,
        password: data.password,
      );
      if (res.session != null) {
        return null; // Successful login
      } else {
        return 'Login failed';
      }
    }
    on AuthException catch (error) {
      return error.toString();
    }
    catch (error) {
      return 'An unexpected error occurred';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: data.name,
        password: data.password!,
      );
      print(res);
      if (res.user != null) {
        return null; // Successful signup
      }
      else {
        return 'Signup failed';
      }
    }
    on AuthException catch (error) {
      return error.message;
    }
    catch (error) {
      return 'An unexpected error occurred';
    }
  }

  Future<String?> _verifyOtp(String otpCode, LoginData data) async {

    AuthResponse? response;

    try {
      response = await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.email,
        token: otpCode,
        email: data.name,
      );
    } catch (e) {
      
    }
    

    if (response == null || response.user == null) {
      return 'Verification code is incorrect!';
    }
  }

  String? validatePassword(String? value){

    if(value == null || value.isEmpty){
      return "Password cannot be empty";
    }

    if(value.length < 6){
      return "Password must be at least 6 characters long";
    }

  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(name);
      return null; // Password reset email sent
    } on AuthException catch (error) {
      return error.message;
    } catch (error) {
      return 'An unexpected error occurred';
    }
  }


}