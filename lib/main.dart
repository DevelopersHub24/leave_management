import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'home/page1.dart';

void main() {
  runApp(const LeaveApp());
}

class LeaveApp extends StatelessWidget {
  const LeaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway-Medium',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: MediaQuery.of(context).size.height, // Set height to device height
            width: MediaQuery.of(context).size.width,   // Set width to device width
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Login Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).animate().fade(duration: 600.ms).moveY(begin: -10, end: 0, curve: Curves.easeOut),
                        const SizedBox(height: 5),
                        const Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ).animate().fade(duration: 600.ms, delay: 200.ms).moveY(begin: -10, end: 0, curve: Curves.easeOut),
                        const SizedBox(height: 20),

                        // User ID Field
                        TextField(
                          style: const TextStyle(color: Colors.white), // Set text color to white
                          decoration: InputDecoration(
                            labelText: 'User  ID',
                            labelStyle: const TextStyle(color: Colors.white60),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                'assets/svgs/user.svg',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        ).animate().fade(duration: 600.ms, delay: 400.ms).moveY(begin: 20, end: 0, curve: Curves.easeOut),
                        const SizedBox(height: 15),

                        // Password Field
                        TextField(
                          style: const TextStyle(color: Colors.white), // Set text color to white
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white60),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                'assets/svgs/password.svg',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: Colors.white60,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white60,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                        ).animate().fade(duration: 600.ms, delay: 600.ms).moveY(begin: 20, end: 0, curve: Curves.easeOut),
                        const SizedBox(height: 20),

                        // Next Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Colors.teal,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Page1()),
                              );
                            },
                            child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ).animate().fade(duration: 600.ms, delay: 800.ms).scaleXY(begin: 0.8, end: 1, curve: Curves.easeOut),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
