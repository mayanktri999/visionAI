import 'package:flutter/material.dart';
import 'driver_dashboard_screen.dart';
import '../utils/permission_helper.dart';

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});


  void onDriverMode(BuildContext context) async {

    bool cameraGranted =
    await PermissionHelper.checkCameraPermission();

    bool notificationGranted =
    await PermissionHelper.checkNotificationPermission();

    if (!cameraGranted) {
      cameraGranted =
      await PermissionHelper.requestCameraPermission();
    }

    if (!notificationGranted) {
      notificationGranted =
      await PermissionHelper.requestNotificationPermission();
    }

    if (cameraGranted && notificationGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DriverDashboardScreen(),
        ),
      );
    } else {
      print("Permission required");
    }
  }


  void onStudyMode(BuildContext context) {
    debugPrint("Study Mode Selected");
    // TODO: Navigate to Study Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3135),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),

              const Text(
                "What do you want to do now?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),


              _modeCard(
                context: context,
                title: "Stay alert while\ndriving",
                bullets: const [
                  "Real-time alerts",
                  "Eye detection",
                  "Safety-first",
                ],
                buttonText: "Driver Mode",
                imagePath: "lib/assets/images/onboarding_car.png",
                onPressed: () => onDriverMode(context), // ✅ NOW WITH PERMISSION
                imageLeft: true,
              ),

              const SizedBox(height: 24),


              _modeCard(
                context: context,
                title: "Stay focused while\nstudying",
                bullets: const [
                  "Pomodoro sessions",
                  "Focus reminders",
                  "Distraction-free",
                ],
                buttonText: "Study Mode",
                imagePath: "lib/assets/images/studymode.png",
                onPressed: () => onStudyMode(context),
                imageLeft: true,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _modeCard({
    required BuildContext context,
    required String title,
    required List<String> bullets,
    required String buttonText,
    required String imagePath,
    required VoidCallback onPressed,
    required bool imageLeft,
  }) {
    return Center(
      child: SizedBox(
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF3A3E42),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imageLeft)
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _modeImage(imagePath),
                  ),
                ),

              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFC37CAB),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...bullets.map(
                            (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• $e",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A4E52),
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(buttonText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (!imageLeft)
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _modeImage(imagePath),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modeImage(String path) {
    return Image.asset(
      path,
      height: 250,
      fit: BoxFit.contain,
    );
  }
}
