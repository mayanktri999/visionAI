import 'package:flutter/material.dart';
import 'mode_selection_screen.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  void onExitDriverMode(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const ModeSelectionScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3135),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3135),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Driver Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// ---------------- PROFILE AVATAR ----------------
            const CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white12,
              child: Icon(
                Icons.person,
                size: 42,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            /// ---------------- NAME ----------------
            const Text(
              "Mayank Tripathi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            /// ---------------- EMAIL ----------------
            const Text(
              "mayank@gmail.com",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            /// ---------------- OPTIONS ----------------
            _profileItem(
              title: "Report Issue",
              iconPath: "lib/assets/icons/report.png",
            ),
            _profileItem(
              title: "Send Feedback",
              iconPath: "lib/assets/images/feedback.png",
            ),
            _profileItem(
              title: "Share App",
              iconPath: "lib/assets/icons/share.png",
            ),

            const Spacer(),

            /// ---------------- EXIT BUTTON ----------------
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => onExitDriverMode(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Exit Driver Mode",
                  style: TextStyle(
                    fontSize: 16,color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- PROFILE OPTION TILE ----------------
  Widget _profileItem({
    required String title,
    required String iconPath,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white38,
      ),
      onTap: () {},
    );
  }
}
