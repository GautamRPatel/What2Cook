import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:what2cook/pages/Register.dart';
import 'package:what2cook/pages/Wrapper.dart';
import 'package:what2cook/service/SnackbarServie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  final Color bgColor = const Color.fromARGB(255, 242, 244, 230);
  final Color cardColor = const Color.fromARGB(255, 251, 252, 248);
  final Color primaryGreen = const Color.fromARGB(255, 133, 163, 118);
  final Color darkText = const Color.fromARGB(255, 45, 51, 42);
  final Color buttonGreen = const Color.fromARGB(229, 64, 89, 51);

  signin() async {
    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email.text.trim())) {
      SnackbarService().showSnackBarMessage('Enter valid email', context);
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (!mounted) return;
      SnackbarService().showSnackBarMessage('Logged in successfully', context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";
      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      } else if (e.code == 'invalid-credential') {
        message = "Invalid email or password";
      } else if (e.code == 'network-request-failed') {
        message = "Please check your internet connection";
      }
      if (!mounted) return;
      SnackbarService().showSnackBarMessage(message, context);

    } catch (e) {
      if (!mounted) return;
      SnackbarService().showSnackBarMessage('Login Failed', context);
    }
    finally{
      setState(() {
        if(mounted) {
          isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What2Cook",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: darkText,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: bgColor,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                child: Text(
                  "WELCOME BACK",
                  style: TextStyle(
                    letterSpacing: 2,
                    height: 1.2,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Center(
                child: Text(
                  "Login to continue your cooking journey",
                  style: TextStyle(
                    color: darkText,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "Email",
                style: TextStyle(color: darkText, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  filled: true,
                  fillColor: cardColor,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),

              const SizedBox(height: 24),

              Text(
                "Password",
                style: TextStyle(color: darkText, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  filled: true,
                  fillColor: cardColor,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryGreen, width: 1.5),
                  ),
                ),
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),

              const SizedBox(height: 40),


              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: signin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Color.fromARGB(255, 251, 252, 248),
                    ),
                  ):
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login_rounded,
                        color: Color.fromARGB(255, 251, 252, 248),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 251, 252, 248),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: darkText.withOpacity(0.7)),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
