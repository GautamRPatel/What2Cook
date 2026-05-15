import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:what2cook/pages/Login.dart';
import 'package:what2cook/service/SnackbarServie.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  final firebaseAuthInstance = FirebaseAuth.instance;
  bool isLoading = false;

  final Color bgColor = const Color.fromARGB(255, 242, 244, 230);
  final Color cardColor = const Color.fromARGB(255, 251, 252, 248);
  final Color primaryGreen = const Color.fromARGB(255, 133, 163, 118);
  final Color darkText = const Color.fromARGB(255, 45, 51, 42);
  final Color buttonGreen = const Color.fromARGB(229, 64, 89, 51);

  Future<void> register() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // await userCredential.user!.updateDisplayName(username.text.trim());

      if (!mounted) return;
      SnackbarService().showSnackBarMessage('Registered Successfully', context);

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      SnackbarService().showSnackBarMessage('Failed To Register', context);
    } finally {
      setState(() {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
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
                  "CREATE ACCOUNT",
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
                  "Create your account to start discovering recipes",
                  style: TextStyle(
                    color: darkText,
                    fontSize: 12.5,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                "Username",
                style: TextStyle(color: darkText, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  hintText: "Enter your username",
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

              const SizedBox(height: 24,),
              Text(
                "Email",
                style: TextStyle(color: darkText, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10,),
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
                  onPressed: register,
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
                        "Register",
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
                    "Already have an account?",
                    style: TextStyle(color: darkText),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Login",
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
