import 'package:flutter/material.dart';
import 'eye_monitoring_screen.dart';
import 'driver_profile_screen.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  void onProfileTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DriverProfileScreen(),
      ),
    );
  }

    void onDriverMode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EyeMonitoringScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3135),
      body: SafeArea(
        child: Stack(
          children: [
            /// ------------------------------------------------
            /// CAMERA PLACEHOLDER (FULL SCREEN)
            /// ------------------------------------------------
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF2D3135),
            ),

            /// ------------------------------------------------
            /// PROFILE ICON (TOP RIGHT)
            /// ------------------------------------------------
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => onProfileTap(context),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white12,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),

            /// ------------------------------------------------
            /// CENTER CAMERA BUTTON
            /// ------------------------------------------------
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white70,
                    width: 2,
                  ),
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFF6E6E6E),
                      Color(0xFF3A3A3A),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

            /// ------------------------------------------------
            /// START DETECTION BUTTON (BOTTOM)
            /// ------------------------------------------------
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => onDriverMode(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A4E52),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Start Detection",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
