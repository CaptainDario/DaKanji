import 'dart:math';
import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/core/widgets/dakanji/dakanji_logo_widget.dart';
import 'package:da_kanji_mobile/globals.dart';

class UserLogin extends StatefulWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onLoginPressed;
  final FormFieldValidator<String>? emailValidator;

  const UserLogin({
    super.key,
    required this.emailController,
    required this.formKey,
    required this.isLoading,
    required this.onLoginPressed,
    this.emailValidator,
  });

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> with TickerProviderStateMixin {
  // --- ANIMATION CONTROLLERS ---
  // Moved inside here so the Parent widget doesn't need to worry about Tickers
  late AnimationController _introController;
  late Animation<double> _flipAnimation;
  late AnimationController _formController;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );

    // Flip Animation
    _flipAnimation = Tween<double>(begin: pi / 2, end: 0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutBack,
      ),
    );

    // Logo Animation
    _logoScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _formController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Small delay before starting animations
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    await _introController.forward();
    if (!mounted) return;
    _formController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return Scaffold(
      // Background color handled by Theme automatically
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- LOGO ---
              ScaleTransition(
                scale: _logoScaleAnimation,
                child: DakanjiLogoWidget(
                  size: 1.2,
                  showVersion: false,
                  useColumn: true,
                ),
              ),
              const SizedBox(height: 40),

              // --- 3D CARD ---
              AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateX(_flipAnimation.value),
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: cardWidth,
                  // Standard Card handles Dark/Light mode automatically
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(cardPadding),
                      child: Form(
                        key: widget.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),

                            // --- EMAIL FIELD ---
                            _AnimatedTextField(
                              controller: widget.emailController,
                              width: textFieldWidth,
                              label: "Email",
                              prefixIcon: Icons.email_outlined,
                              loadingController: _formController,
                              interval: const Interval(0, 0.85),
                              validator: widget.emailValidator,
                            ),

                            const SizedBox(height: 20),

                            // --- LOGIN BUTTON ---
                            _AnimatedButton(
                              loadingController: _formController,
                              interval: const Interval(
                                0.6,
                                1.0,
                                curve: Curves.easeInExpo
                              ),
                              isLoading: widget.isLoading,
                              onPressed: widget.onLoginPressed,
                              text: "SEND MAGIC LINK",
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- ANIMATED FIELD (Left Anchored) ---
class _AnimatedTextField extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final String label;
  final IconData prefixIcon;
  final AnimationController loadingController;
  final Interval interval;
  final FormFieldValidator<String>? validator;

  const _AnimatedTextField({
    required this.controller,
    required this.width,
    required this.label,
    required this.prefixIcon,
    required this.loadingController,
    required this.interval,
    this.validator,
  });

  @override
  State<_AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<_AnimatedTextField> {
  late Animation<double> _scaleAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.loadingController,
        curve: _getInternalInterval(0, 0.2, widget.interval.begin, widget.interval.end, Curves.easeOutBack),
      ),
    );
    _sizeAnimation = Tween<double>(begin: 48, end: widget.width).animate(
      CurvedAnimation(
        parent: widget.loadingController,
        curve: _getInternalInterval(0.2, 1, widget.interval.begin, widget.interval.end, Curves.linearToEaseOut),
        reverseCurve: Curves.easeInExpo,
      ),
    );
  }

  Interval _getInternalInterval(double start, double end, double externalStart, double externalEnd, [Curve curve = Curves.linear]) {
    return Interval(
      externalStart + (end - start) * externalStart,
      externalStart + (end - start) * externalEnd,
      curve: curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ScaleTransition(
          scale: _scaleAnimation,
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _sizeAnimation,
            builder: (context, child) => ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: _sizeAnimation.value),
              child: child,
            ),
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.prefixIcon, size: 20),
                labelText: widget.label,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- ANIMATED BUTTON ---
class _AnimatedButton extends StatelessWidget {
  final AnimationController loadingController;
  final Interval interval;
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;

  const _AnimatedButton({
    required this.loadingController,
    required this.interval,
    required this.isLoading,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: loadingController, curve: interval),
    );

    return ScaleTransition(
      scale: scaleAnimation,
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: g_color_scheme_green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}