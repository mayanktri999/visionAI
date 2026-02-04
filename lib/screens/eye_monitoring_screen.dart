import 'package:flutter/material.dart';
import 'drowsiness_alert_screen.dart';
import 'summary_screen.dart';

class EyeMonitoringScreen extends StatefulWidget {
  const EyeMonitoringScreen({super.key});

  @override
  State<EyeMonitoringScreen> createState() => _EyeMonitoringScreenState();
}

class _EyeMonitoringScreenState extends State<EyeMonitoringScreen> {
  bool isAlertShowing = false;

  /// 👉 THIS WILL BE CALLED BY AI LATER
  void onDrowsinessDetected() {
    if (isAlertShowing) return;

    isAlertShowing = true;

    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const DrowsinessAlertScreen(),
      ),
    ).then((_) {
      isAlertShowing = false; // resume monitoring
    });
  }

  void onStopDetection() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SummaryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            /// FULL CAMERA PREVIEW (placeholder)
            Positioned.fill(
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Icon(
                    Icons.videocam,
                    color: Colors.white24,
                    size: 90,
                  ),
                ),
              ),
            ),

            /// EYE STATUS
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Eyes Open",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            /// STOP DETECTION
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: onStopDetection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4E52),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Stop Detection",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            /// TEMP BUTTON (REMOVE LATER – for testing alert)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: OutlinedButton(
                onPressed: onDrowsinessDetected,
                child: const Text(
                  "Simulate Eye Closure",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
