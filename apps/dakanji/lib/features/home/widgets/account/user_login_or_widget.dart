import 'package:da_kanji_mobile/core/supabase/controller/supabase_auth.dart';
import 'package:da_kanji_mobile/features/home/widgets/account/user_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserLoginOrWidget extends StatefulWidget {
  final Widget widget;

  const UserLoginOrWidget(this.widget, {super.key});

  @override
  State<UserLoginOrWidget> createState() => _UserLoginOrWidgetState();
}

class _UserLoginOrWidgetState extends State<UserLoginOrWidget> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    if(kDebugMode) _emailController.text = "daapplab@gmail.com";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. LISTEN TO AUTH STATE CHANGES
    // This StreamBuilder waits for Supabase to detect the magic link
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        
        // Check current session either from snapshot or directly from client
        final session = snapshot.data?.session ?? Supabase.instance.client.auth.currentSession;

        // 2. LOGIC: If we have a session, show the protected widget
        if (session != null) {
          // You can add your FadeTransition wrapper here if you want it to animate 
          // when the user gets logged in.
          return widget.widget; 
        }

        // 3. LOGIC: No session? Show Login
        return UserLogin(
          emailController: _emailController,
          formKey: _formKey,
          isLoading: _isLoading,
          onLoginPressed: _handleLogin,
          emailValidator: (val) =>
              (val == null || !val.contains('@')) ? "Invalid Email" : null,
        );
      },
    );
  }

  // LOGIC: Send the Magic Link
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 4. API CALL
      // Ensure you set the redirectTo to match your Deep Link configuration
      await signInWithOp(_emailController.text);

      if (!mounted) return;

      // 5. USER FEEDBACK (Do not navigate!)
      // Just tell the user to check their email.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check your email for the login link!')),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}