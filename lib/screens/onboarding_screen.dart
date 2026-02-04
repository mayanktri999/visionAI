import 'package:flutter/material.dart';
import 'auth_screen.dart';

/// DATA MODEL (each onboarding page is fully customizable)
class OnboardingPageData {
  final String title;
  final String subtitle;
  final String image;

  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  final Color titleColor;
  final Color subtitleColor;

  final double titleSize;
  final double subtitleSize;
  final double imageHeight;

  OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.image,
    this.backgroundColor,
    this.backgroundGradient,
    required this.titleColor,
    required this.subtitleColor,
    required this.titleSize,
    required this.subtitleSize,
    required this.imageHeight,
  });
}

/// ------------------------------------------------------------
/// ONBOARDING SCREEN
/// ------------------------------------------------------------
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentIndex = 0;
  bool isLastPageSettled = false;

  /// ------------------------------------------------------------
  /// ONBOARDING DATA
  /// ------------------------------------------------------------
  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: "FOCUS ON\nTHE ROAD",
      subtitle: "Drive safely with intelligent,\ndistraction free navigation.",
      image: "lib/assets/images/onboarding_car.png",
      backgroundColor: const Color(0xFF2D3135),
      titleColor: Colors.white,
      subtitleColor: Colors.white70,
      titleSize: 36,
      subtitleSize: 16,
      imageHeight: 500,
    ),
    OnboardingPageData(
      title: "DEEP WORK,\nDELIVERED",
      subtitle: "Optimize your study sessions\nwith the pomodoro techniques.",
      image: "lib/assets/images/onboarding_study.png",
      backgroundColor: const Color(0xFFC7C9CC),
      titleColor: const Color(0xFF2F4C8A),
      subtitleColor: Colors.black54,
      titleSize: 34,
      subtitleSize: 16,
      imageHeight: 300,
    ),
    OnboardingPageData(
      title: "SEAMLESSLY\nSWITCH MODES",
      subtitle: "Your focus, your rules,\nanywhere you go.",
      image: "lib/assets/images/onboarding_switch.png",
      backgroundGradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF28457E),
          Color(0xFF75C7D3),
        ],
      ),
      titleColor: Colors.white,
      subtitleColor: Colors.white70,
      titleSize: 34,
      subtitleSize: 16,
      imageHeight: 290,
    ),
  ];

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// PAGE VIEW
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                isLastPageSettled = index == pages.length - 1;
              });
            },
            itemBuilder: (context, index) {
              final page = pages[index];

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: page.backgroundGradient == null
                      ? page.backgroundColor
                      : null,
                  gradient: page.backgroundGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    /// Skip
                    if (currentIndex != pages.length - 1)
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => goToLogin(context),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: page.subtitleColor,
                            ),
                          ),
                        ),
                      ),




                    const SizedBox(height: 20),

                    /// Title
                    Text(
                      page.title,
                      style: TextStyle(
                        fontSize: page.titleSize,
                        fontWeight: FontWeight.bold,
                        color: page.titleColor,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Subtitle
                    Text(
                      page.subtitle,
                      style: TextStyle(
                        fontSize: page.subtitleSize,
                        color: page.subtitleColor,
                      ),
                    ),

                    const Spacer(),

                    /// Image
                    Center(
                      child: Image.asset(
                        page.image,
                        height: page.imageHeight,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              );
            },
          ),

          /// BOTTOM SECTION
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: currentIndex == index ? 18 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Get Started
                if (isLastPageSettled)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => goToLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
