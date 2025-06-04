import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/Home/home.dart';
import 'package:tanda_kata/Screens/Profile/profile_screen.dart';
import 'package:tanda_kata/Screens/components/home_body.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final int _currIdx = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              'History Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _currIdx == 2 ? Colors.white : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      if (_currIdx != 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
