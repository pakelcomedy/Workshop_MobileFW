import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure that the intl dependency is added in pubspec.yaml

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State variables for non-text inputs
  String? _selectedGender;
  DateTime? _selectedDate;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Gender options
  final List<String> _genderOptions = ['Laki-laki', 'Perempuan', 'Lainnya'];

  // Date formatter for birthday
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _alamatController.dispose();
    _nomorController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to pick date using DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Pilih Tanggal Lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Function to simulate registration submission
  Future<void> _submitRegistration() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a delay for registration (e.g., API call)
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrasi Berhasil'),
            content: const Text('Akun Anda telah berhasil didaftarkan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Here you can navigate to the login page if needed
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  // Helper: Input border style
  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.blue),
    );
  }

  // Helper: Input decoration style
  InputDecoration _buildInputDecoration(String label, {IconData? icon, Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blue),
      prefixIcon: icon != null ? Icon(icon, color: Colors.blue) : null,
      border: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
      suffixIcon: suffixIcon,
    );
  }

  // Enhanced header with a gradient avatar border
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_add, color: Colors.blue.shade700, size: 36),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Register Now',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    );
  }

  // Widget for the full name field
  Widget _buildNamaField() {
    return TextFormField(
      controller: _namaController,
      decoration: _buildInputDecoration('Nama Lengkap'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nama lengkap harus diisi';
        }
        return null;
      },
    );
  }

  // Widget for the username field
  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: _buildInputDecoration('Username'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Username harus diisi';
        }
        if (value.trim().length < 4) {
          return 'Username minimal 4 karakter';
        }
        return null;
      },
    );
  }

  // Widget for the gender dropdown field
  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      decoration: _buildInputDecoration('Gender'),
      value: _selectedGender,
      items: _genderOptions.map((gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Pilih gender Anda';
        }
        return null;
      },
    );
  }

  // Widget for the address field
  Widget _buildAlamatField() {
    return TextFormField(
      controller: _alamatController,
      decoration: _buildInputDecoration('Alamat'),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Alamat harus diisi';
        }
        return null;
      },
    );
  }

  // Widget for the phone number field
  Widget _buildNomorField() {
    return TextFormField(
      controller: _nomorController,
      decoration: _buildInputDecoration('Nomor Telefon', icon: Icons.phone),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Nomor telefon harus diisi';
        }
        if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
          return 'Nomor telefon hanya boleh berisi angka';
        }
        return null;
      },
    );
  }

  // Widget for the email field
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _buildInputDecoration('Email', icon: Icons.email),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email harus diisi';
        }
        if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value.trim())) {
          return 'Masukkan email yang valid';
        }
        return null;
      },
    );
  }

  // Widget for the date of birth field with DatePicker
  Widget _buildDateBirthField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Tanggal Lahir',
            labelStyle: const TextStyle(color: Colors.blue),
            border: _buildOutlineInputBorder(),
            focusedBorder: _buildOutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
          ),
          controller: TextEditingController(
            text: _selectedDate != null ? _dateFormat.format(_selectedDate!) : '',
          ),
          validator: (value) {
            if (_selectedDate == null) {
              return 'Pilih tanggal lahir Anda';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Widget for the password field with toggle visibility
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: _buildInputDecoration(
        'Password',
        icon: Icons.lock,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.blue,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Password harus diisi';
        }
        if (value.trim().length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  // Main widget for the registration form
  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildNamaField(),
          const SizedBox(height: 16),
          _buildUsernameField(),
          const SizedBox(height: 16),
          _buildGenderField(),
          const SizedBox(height: 16),
          _buildAlamatField(),
          const SizedBox(height: 16),
          _buildNomorField(),
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildDateBirthField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 24),
          GradientButton(
            onPressed: _submitRegistration,
            text: 'Register',
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  // Build method for the registration page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar for a modern look
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Subtle blur effect for a glassmorphism feel
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.black.withOpacity(0.05),
            ),
          ),
          // Registration form wrapped in a scrollable card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: _buildRegisterForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Gradient Button Widget
class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isLoading ? null : onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}