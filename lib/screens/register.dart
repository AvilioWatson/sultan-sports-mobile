import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sultan_sports/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      // =======================
      // APP BAR TEMA AMBER GELAP
      // =======================
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color(0xFFCC7A00), // amber gelap
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      // ================================
      // BACKGROUND GRADIENT AMBER GELAP
      // ================================
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFB84D), // amber terang
              Color(0xFFE69138), // amber sedang
              Color(0xFFCC7A00), // amber gelap
            ],
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),

            child: Card(
              color: Colors.white.withOpacity(0.92),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCC7A00),
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    // ======================
                    // USERNAME FIELD
                    // ======================
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFCC7A00), width: 2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // ======================
                    // PASSWORD FIELD
                    // ======================
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFCC7A00), width: 2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12.0),

                    // ======================
                    // CONFIRM PASSWORD FIELD
                    // ======================
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFCC7A00), width: 2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      obscureText: true,
                    ),

                    const SizedBox(height: 24.0),

                    // ======================
                    // REGISTER BUTTON (AMBER GELAP)
                    // ======================
                    ElevatedButton(
                      onPressed: () async {
                        String username = _usernameController.text;
                        String password1 = _passwordController.text;
                        String password2 = _confirmPasswordController.text;

                        final response = await request.postJson(
                          "http://localhost:8000/auth/register/",
                          jsonEncode({
                            "username": username,
                            "password1": password1,
                            "password2": password2,
                          }),
                        );

                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully registered!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to register!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFCC7A00),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
