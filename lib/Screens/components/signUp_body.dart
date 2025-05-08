import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/Login/login_screen.dart';
import 'package:tanda_kata/color.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              // First
              const Text(
                "Create an account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              // Second Text
              const Text(
                "Please enter your username, and password. Don’t worry, your data will remain private and only you can see it.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 73),

              // Username TextField
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username*",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.check,
                        color: Colors.grey,
                      ),
                      hintText: "Enter your username",
                      hintStyle: TextStyle(color: hint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: highlighted),
                      ),
                    ),
                  ),
                  SizedBox(height: 47),

                  // Password TextField
                  Text(
                    "Password*",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: hint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: highlighted),
                      ),
                    ),
                  ),
                  SizedBox(height: 47),

                  //Confirm Password
                  Text(
                    "Confirm Password*",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      hintText: "Enter your confirm password",
                      hintStyle: TextStyle(color: hint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: highlighted),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Forget Password?
              // const Align(
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     "Forgot Password?",
              //     style: TextStyle(fontSize: 15, color: grey),
              //   ),
              // ),
              const SizedBox(height: 47),

              // Sign Up Button
              SizedBox(
                width: 350,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: primaryColor,
                        offset: Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // Didn't have an account
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Login Here!",
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
