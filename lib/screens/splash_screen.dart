import 'dart:math';
import 'package:flutter/material.dart';
import 'package:visionai/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mode_selection_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _eyeBallController;

  late Animation<double> _eyeScale;
  late Animation<double> _eyeSlide;
  late Animation<double> _visionSlide;
  late Animation<double> _visionOpacity;
  late Animation<double> _taglineSlide;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    _eyeBallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );


    _eyeBallController.repeat();


    _mainController.addListener(() {
      if (_mainController.value >= 0.55 &&
          _eyeBallController.isAnimating) {
        _eyeBallController.stop();
      }
    });

    _eyeScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.15, 0.40, curve: Curves.easeOutBack),
      ),
    );

    _eyeSlide = Tween<double>(begin: 0, end: -85).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.40, 0.55, curve: Curves.easeOut),
      ),
    );

    _visionSlide = Tween<double>(begin: -40, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 0.78, curve: Curves.easeOut),
      ),
    );

    _visionOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.60, 0.75),
      ),
    );

    _taglineSlide = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.78, 0.95, curve: Curves.easeOut),
      ),
    );

    _taglineOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.78, 0.95),
      ),
    );

    _mainController.forward();
    _mainController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {

        final prefs = await SharedPreferences.getInstance();
        bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

        if (!mounted) return;

        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ModeSelectionScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            ),
          );
        }
      }
    });

  }

  @override
  void dispose() {
    _mainController.dispose();
    _eyeBallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _mainController,
            _eyeBallController,
          ]),
          builder: (context, _) {

            final double angle = _eyeBallController.value * 2 * pi;
            final double radiusX = 8;
            final double radiusY = 6;

            final double eyeBallX = cos(angle) * radiusX;
            final double eyeBallY = sin(angle) * radiusY;

            return Stack(
              clipBehavior: Clip.none,
              children: [

                Transform.translate(
                  offset: Offset(_eyeSlide.value, 0),
                  child: ScaleTransition(
                    scale: _eyeScale,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/images/eye2.png',
                          width: 81,
                          height: 55,
                        ),


                        Transform.translate(
                          offset: Offset(eyeBallX, eyeBallY),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Positioned(
                  left: 81 - 95 + _visionSlide.value,
                  child: Opacity(
                    opacity: _visionOpacity.value,
                    child: Image.asset(
                      'lib/assets/images/visionai.png',
                      width: 190,
                      height: 52,
                    ),
                  ),
                ),


                Positioned(
                  top: 48 + 0.3 + _taglineSlide.value,
                  left: 80 - 77,
                  child: Opacity(
                    opacity: _taglineOpacity.value,
                    child: Image.asset(
                      'lib/assets/images/stayawakeandfocused.png',
                      width: 160,
                      height: 15,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
