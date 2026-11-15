import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
final TextEditingController _nameController =
TextEditingController();

final TextEditingController _emailController =
TextEditingController();

final TextEditingController _passwordController =
TextEditingController();

final TextEditingController _confirmPasswordController =
TextEditingController();

@override
void dispose() {
_nameController.dispose();
_emailController.dispose();
_passwordController.dispose();
_confirmPasswordController.dispose();
super.dispose();
}

Future<void> _signUp() async {
if (_nameController.text.trim().isEmpty ||
_emailController.text.trim().isEmpty ||
_passwordController.text.isEmpty ||
_confirmPasswordController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Please fill in all fields'),
),
);
return;
}

if (_passwordController.text.length < 6) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Password must be at least 6 characters'),
),
);
return;
}

if (_passwordController.text !=
_confirmPasswordController.text) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Passwords do not match'),
),
);
return;
}

final authProvider = context.read<AuthProvider>();

final success = await authProvider.signUp(
fullName: _nameController.text,
email: _emailController.text,
password: _passwordController.text,
);

if (!mounted) return;

if (success) {
Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => HomeScreen(),
),
);
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
authProvider.errorMessage ?? 'Registration failed',
),
),
);
}
}

@override
Widget build(BuildContext context) {
final isLoading = context.watch<AuthProvider>().isLoading;

return Scaffold(
backgroundColor: Colors.white,

appBar: AppBar(),

body: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(25),

child: Column(
children: [

Image.asset(
"assets/logo/logo1.jfif",
width: 200,
),

const SizedBox(height: 20),

const Text(
"Create Account",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 30),

CustomTextField(
hint: "Full Name",
icon: Icons.person_outline,
controller: _nameController,
),

CustomTextField(
hint: "Email",
icon: Icons.email_outlined,
controller: _emailController,
keyboardType: TextInputType.emailAddress,
),

CustomTextField(
hint: "Password",
icon: Icons.lock_outline,
isPassword: true,
controller: _passwordController,
),

CustomTextField(
hint: "Confirm Password",
icon: Icons.lock_outline,
isPassword: true,
controller: _confirmPasswordController,
),
  const SizedBox(height: 20),

  SizedBox(
    width: double.infinity,
    height: 55,

    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),

      onPressed: isLoading ? null : _signUp,

      child: isLoading
          ? const CircularProgressIndicator(
        color: Colors.white,
      )
          : const Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white,
        ),
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