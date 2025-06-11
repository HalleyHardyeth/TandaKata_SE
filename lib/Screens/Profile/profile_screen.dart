import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/History/history_screen.dart';
import 'package:tanda_kata/Screens/Home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currIdx = 2;

  final TextEditingController _nameController =
      TextEditingController(text: 'Parker');
  final TextEditingController _usernameController =
      TextEditingController(text: 'parker_23');
  final TextEditingController _socialMediaController =
      TextEditingController(text: '@parker_2323');

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
                // Header section
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD1ECE9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.teal,
                        child:
                            Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Parker',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'parker_23',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Form fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      buildInputField('Name', _nameController,
                          hintText: 'Enter your name'),
                      const SizedBox(height: 30),
                      buildInputField('Username', _usernameController,
                          hintText: 'Enter your username'),
                      const SizedBox(height: 30),
                      buildInputField('Social Media', _socialMediaController,
                          hintText: 'Enter your social media'),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Simpan aksi di sini
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
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF2D8374),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _currIdx == 0 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_currIdx != 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.history,
                      color: _currIdx == 1 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_currIdx != 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HistoryScreen()),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _currIdx == 2 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
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
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            isDense: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}
