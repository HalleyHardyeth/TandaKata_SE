import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tanda_kata/Screens/Home/home.dart';
import 'package:tanda_kata/Screens/Login/login_screen.dart';
import 'package:tanda_kata/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currIdx = 2;
  File? _imageFile;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
    checkAndUpdateEmailInFirestore();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _emailController.text = userDoc['email'] ?? '';
          _usernameController.text = userDoc['username'] ?? '';
          _socialMediaController.text = userDoc['social_media'] ?? '';
        });
      }
    }
  }

  Future<void> saveUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final newEmail = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final socialMedia = _socialMediaController.text.trim();

    try {
      final password = await _showPasswordDialog(context);
      if (password == null || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password is required to update email")),
        );
        return;
      }

      // Re-authenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Update email in Authentication
      if (newEmail != user.email) {
        await user.verifyBeforeUpdateEmail(newEmail);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Verification email sent. Please check your inbox to confirm the email change."),
          ),
        );
      }

      // Update Firestore data
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'username': username,
        'social_media': socialMedia,
      });

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Profile updated (email pending verification)")),
      );
    } catch (e) {
      debugPrint('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: ${e.toString()}")),
      );
    }
  }

  Future<void> checkAndUpdateEmailInFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final firestoreEmail = userDoc.data()?['email'];

      if (firestoreEmail != user.email) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'email': user.email});
      }
    }
  }

  Future<String?> _showPasswordDialog(BuildContext context) async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Re-enter Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Password"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text("Confirm")),
        ],
      ),
    );
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      final userId = FirebaseAuth.instance.currentUser!.uid;
      final ref =
          FirebaseStorage.instance.ref().child('profile_url/$userId.jpg');

      await ref.putFile(_imageFile!);
      final Url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'photoUrl': Url,
      });

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
                  width: double.infinity,
                  height: 320,
                  decoration: BoxDecoration(
                    color: softGreen,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.8),
                        offset: const Offset(0, 10),
                        blurRadius: 0,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                );
                              },
                            ),
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.logout),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.teal,
                              child: Icon(Icons.person,
                                  size: 55, color: Colors.white),
                            );
                          }

                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final photoUrl = data['photoUrl'];

                          return GestureDetector(
                            onTap: pickAndUploadImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: photoUrl != null
                                  ? NetworkImage(photoUrl)
                                  : null,
                              child: photoUrl == null
                                  ? const Icon(Icons.add_a_photo,
                                      size: 30, color: Colors.black)
                                  : null,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _usernameController.text,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      if (_socialMediaController.text.trim().isNotEmpty)
                        Text(
                          _socialMediaController.text.trim().startsWith('@')
                              ? _socialMediaController.text.trim()
                              : '@${_socialMediaController.text.trim()}',
                          style: const TextStyle(color: grey),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 65),

                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      buildInputField('Email', _emailController,
                          hintText: 'Enter your email'),
                      const SizedBox(height: 35),
                      buildInputField('Username', _usernameController,
                          hintText: 'Enter your username'),
                      const SizedBox(height: 35),
                      buildInputField('Social Media', _socialMediaController,
                          hintText: 'Enter your social media'),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          saveUserData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD1ECE9),
                          foregroundColor: Colors.teal.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Color(0xFF2D8374)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                        ),
                        child: const Text('Save'),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller,
      {required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(129, 245, 176, 37),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
