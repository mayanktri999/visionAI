import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'mode_selection_screen.dart';
import 'edit_profile_screen.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {

  String userName = "";
  String userEmail = "";
  File? profileImage;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString('user_name') ?? "User Name";
      userEmail = prefs.getString('user_email') ?? "user@email.com";

      String? imagePath = prefs.getString('profile_image');
      if (imagePath != null) {
        profileImage = File(imagePath);
      }
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', picked.path);

      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  const EditProfileScreen(),
                ),
              );
              loadUserData(); // refresh after edit
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [


            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white12,
                backgroundImage:
                profileImage != null ? FileImage(profileImage!) : null,
                child: profileImage == null
                    ? const Icon(
                  Icons.person,
                  size: 42,
                  color: Colors.white,
                )
                    : null,
              ),
            ),

            const SizedBox(height: 12),


            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),


            Text(
              userEmail,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),


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
                    fontSize: 16,
                    color: Colors.white,
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