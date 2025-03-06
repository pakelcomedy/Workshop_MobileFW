import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workshop_mobile/resetpassword/reset_password_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // Animation controller for logo animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Toggle for showing or hiding password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Simulated login function
  Future<void> _submitLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API delay
      await Future.delayed(Duration(seconds: 2));
      
      if (_emailController.text == "user@example.com" && _passwordController.text == "password") {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login gagal, periksa kredensial Anda"),
            backgroundColor: Colors.red,
          ),
        );
      }
      
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Logo with fade animation
  Widget _buildLogo() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Icon(Icons.mobile_friendly, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            "Workshop Mobile",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800]),
          )
        ],
      ),
    );
  }

  // Email field with validation
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(Icons.email, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email tidak boleh kosong";
        }
        if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
          return "Masukkan email yang valid";
        }
        return null;
      },
    );
  }

  // Password field with toggle and validation
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscureText,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(Icons.lock, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.blue),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password tidak boleh kosong";
        }
        if (value.length < 6) {
          return "Password minimal 6 karakter";
        }
        return null;
      },
    );
  }

  // "Remember Me" checkbox
  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.blue,
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
        ),
        Text("Ingat saya", style: TextStyle(color: Colors.black87))
      ],
    );
  }

  // "Forgot Password?" link with reset password bottom sheet
  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Show reset password bottom sheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => ResetPasswordBottomSheet(),
          );
        },
        child: Text("Lupa Password?", style: TextStyle(color: Colors.blue)),
      ),
    );
  }

  // Login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitLogin,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.blue,
        ),
        child: _isLoading 
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ))
            : Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  // Social login buttons
  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          icon: Icons.facebook,
          color: Colors.blueAccent,
          message: "Login dengan Facebook belum tersedia",
        ),
        SizedBox(width: 16),
        _socialButton(
          icon: Icons.g_mobiledata,
          color: Colors.redAccent,
          message: "Login dengan Google belum tersedia",
        ),
        SizedBox(width: 16),
        _socialButton(
          icon: Icons.apple,
          color: Colors.black,
          message: "Login dengan Apple belum tersedia",
        ),
      ],
    );
  }

  Widget _socialButton({required IconData icon, required Color color, required String message}) {
    return IconButton(
      icon: Icon(icon, color: color, size: 32),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
    );
  }

  // Registration link
  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Belum punya akun?", style: TextStyle(color: Colors.black87)),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: Text(
            "Daftar",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // New background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Subtle blur effect for glassmorphism
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLogo(),
                      SizedBox(height: 24),
                      _buildEmailField(),
                      SizedBox(height: 16),
                      _buildPasswordField(),
                      _buildForgotPassword(),
                      _buildRememberMeCheckbox(),
                      SizedBox(height: 24),
                      _buildLoginButton(),
                      SizedBox(height: 16),
                      _buildSocialLoginButtons(),
                      SizedBox(height: 16),
                      _buildRegisterLink(),
                    ],
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