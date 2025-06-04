import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _obscurePassword = true;

  Future<void> signUpUser() async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassController.text.trim();

    if (email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackbar("Please fill all fields");
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      showSnackbar("Please enter a valid email");
      return;
    }

    if (password.length < 8) {
      showSnackbar("Password must be at least 8 characters");
      return;
    }

    if (password != confirmPassword) {
      showSnackbar("Passwords do not match");
      return;
    }

    try {
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

      // Simpan data ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      showSnackbar("Sign up successful");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackbar("Email is already registered.");
      } else {
        showSnackbar("Firebase error: ${e.message}");
      }
    } catch (e) {
      showSnackbar("Unexpected error: $e");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
                "Create an account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              const Text(
                "Welcome! Let’s create your personal account so you can explore all features and stay connected.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 50),

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
                  const SizedBox(height: 3),
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

                  // Username TextField
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Username',
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
                  const SizedBox(height: 3),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 3),
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
                  const SizedBox(height: 35),

                  //Confirm Password TextField
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Confirm Password',
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
                  const SizedBox(height: 3),
                  TextField(
                    controller: confirmPassController,
                    obscureText: true,
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
                      hintText: "Enter your confirm password",
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
              const SizedBox(height: 40),

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
                    onPressed: () {
                      signUpUser();
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
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Already have an account
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
