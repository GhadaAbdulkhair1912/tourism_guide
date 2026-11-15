import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final TextEditingController _emailController =
TextEditingController();

final TextEditingController _passwordController =
TextEditingController();

@override
void dispose() {
_emailController.dispose();
_passwordController.dispose();
super.dispose();
}

Future<void> _login() async {
if (_emailController.text.trim().isEmpty ||
_passwordController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Please enter email and password'),
),
);
return;
}

final authProvider = context.read<AuthProvider>();

final success = await authProvider.login(
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
authProvider.errorMessage ?? 'Login failed',
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

body: SafeArea(
child: SingleChildScrollView(
child: Padding(
padding: const EdgeInsets.all(25),

child: Column(
children: [

const SizedBox(height: 30),

const Text(
"Welcome Back",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 15),

Image.asset(
"assets/logo/logo1.jfif",
width: 200,
),

const SizedBox(height: 30),

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

Align(
alignment: Alignment.centerRight,
child: TextButton(
onPressed: () {},
child: const Text(
"Forgot Password?",
),
),
),

const SizedBox(height: 20),

SizedBox(
width: double.infinity,
height: 55,

child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.primary,
),

onPressed: isLoading ? null : _login,

child: isLoading
? const CircularProgressIndicator(
color: Colors.white,
)
: const Text(
"Login",
style: TextStyle(
color: Colors.white,
),
),
),
),
  const SizedBox(height: 25),

  Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: [

      const Text(
        "Don't have an account?",
      ),

      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SignupScreen(),
            ),
          );
        },

        child: const Text(
          "Sign Up",
        ),
      ),
    ],
  ),
],
),
),
),
),
);
}
}