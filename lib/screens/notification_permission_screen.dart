import 'package:flutter/material.dart';
import 'mode_selection_screen.dart';



class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});
  void onSkip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ModeSelectionScreen(),
      ),
    );
  }

  void onAllow(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ModeSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3135),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              /// ------------------------------------------------
              /// TOP BAR (Skip)
              /// ------------------------------------------------
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => onSkip(context),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// ------------------------------------------------
              /// IMAGE
              /// ------------------------------------------------
              Transform.translate(
                offset: const Offset(-12, 0), // slight left shift
                child: Image.asset(
                  'lib/assets/images/notification_permission.png',
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              /// ------------------------------------------------
              /// TITLE
              /// ------------------------------------------------
              const Text(
                "Notification\nAccess Required",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 16),

              /// ------------------------------------------------
              /// DESCRIPTION
              /// ------------------------------------------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enable notifications to get instant alerts when drowsiness is detected or focus time ends.",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFC37CAB),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ------------------------------------------------
              /// BULLET POINTS
              /// ------------------------------------------------
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PermissionPoint(text: "Drowsiness warnings"),
                  PermissionPoint(text: "Pomodoro reminders"),
                  PermissionPoint(text: "No promotional spam"),
                ],
              ),

              const Spacer(),

              /// ------------------------------------------------
              /// ALLOW BUTTON
              /// ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => onAllow(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49494A),
                    foregroundColor:const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Allow Notifications",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// BULLET POINT WIDGET
/// ------------------------------------------------------------
class PermissionPoint extends StatelessWidget {
  final String text;

  const PermissionPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15, // 👈 slightly bigger for readability
            ),
          ),
        ],
      ),
    );
  }
}
