import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/Login/login_screen.dart';
import 'package:tanda_kata/Screens/SignUp/signUp_screen.dart';
import 'package:tanda_kata/color.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // PNG image
            Image.asset(
              "assets/images/welcome.png",
              height: size.height * 0.3,
            ),
            const SizedBox(height: 35), // Space between image and buttons

            const Text(
              "Tangan Merangkai Tanda, Hati Merajut Makna, Bersama Kita Berbicara dalam Sunyi",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 70),

            // Get Started Button
            SizedBox(
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: shadow1,
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: shadow2),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 17),

            // Already Have an Account Button
            SizedBox(
              width: 300,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: shadow2,
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: primaryColor),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "I ALREADY HAVE AN ACCOUNT",
                    style: TextStyle(fontSize: 15, color: primaryColor),
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
