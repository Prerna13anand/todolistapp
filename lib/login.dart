// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:todolist/HomePage.dart';

import 'signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}


class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: Text('Login Page'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildRoundedContainer(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        _buildRoundedContainer(
                          controller: _passwordController,
                          hintText: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                          isPasswordVisible: _isPasswordVisible,
                          togglePasswordVisibility: _togglePasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'Password must contain at least one uppercase letter';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Password must contain at least one number';
                            }
                            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                              return 'Password must contain at least one special character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                        _isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                          onTap: _login,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade300,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton.icon(
                          icon: Icon(Icons.login),
                          label: Text('Sign up with Google'),
                          onPressed: () {
                            // Implement your Google sign-up logic here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue.shade300,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedContainer({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    void Function()? togglePasswordVisibility,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: togglePasswordVisibility,
          )
              : null,
        ),
        obscureText: isPassword && !isPasswordVisible,
        validator: validator,
      ),
    );
  }
}
