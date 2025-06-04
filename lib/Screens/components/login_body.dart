import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/Home/home.dart';
import 'package:tanda_kata/Screens/SignUp/signUp_screen.dart';
import 'package:tanda_kata/color.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _obscurePassword = true;

  Future<void> loginUser() async {
    String password = passwordController.text.trim();
    String email = emailController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Please field email and password");
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showError("No user found with this email.");
      } else if (e.code == 'wrong-password') {
        _showError("Incorrect password. Please try again.");
      } else {
        _showError("Login failed: ${e.message}");
      }
    } catch (e) {
      _showError("Unexpected error: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Text(
                "Welcome to TandaKata!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              const Text(
                "Welcome back! Log in to continue your journey with TandaKata and enjoy a more personalized experience.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 60),

              // Form TextField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email TextField
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Email',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: hint),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: highlighted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Password TextField
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _obscurePassword ? Colors.grey : primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(color: hint),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
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
              const SizedBox(height: 55),

              // Login Button
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
                    onPressed: () {
                      loginUser();
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
                      "Login",
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
                      const TextSpan(text: "Didn't have an account? "),
                      TextSpan(
                        text: "Register Here!",
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
                                  builder: (context) => const SignupPage()),
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
