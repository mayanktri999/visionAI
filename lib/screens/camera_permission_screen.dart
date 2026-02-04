import 'package:flutter/material.dart';
import 'notification_permission_screen.dart';
import 'mode_selection_screen.dart';



class CameraPermissionScreen extends StatelessWidget {
  const CameraPermissionScreen({super.key});
  void onSkip(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ModeSelectionScreen(),
      ),
    );
  }


  void onAllow(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationPermissionScreen(),
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
            offset: const Offset(-20, 0), // 👈 move LEFT (try -10 to -30)
            child:    Image.asset(
                'lib/assets/images/camera_permission.png',
                height: 220,
                fit: BoxFit.contain,
              ),
          ),

              const SizedBox(height: 40),

              /// ------------------------------------------------
              /// TITLE
              /// ------------------------------------------------
              const Text(
                "Camera Access\nRequired",
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
                  "VisionAI uses your camera to detect eye closure and prevent drowsiness.",
                  style: const TextStyle(
                    fontSize: 16,
                   color: Color(0xFFC37CAB), // keep red if you want
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
                  PermissionPoint(text: "On-device processing",),
                  PermissionPoint(text: "Privacy-first design"),
                  PermissionPoint(text: "No photos or videos"),

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
                    backgroundColor:const Color(0xFF49494A),
                    foregroundColor:const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Allow Camera",
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
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
