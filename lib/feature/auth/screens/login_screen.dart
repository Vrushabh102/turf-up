import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turf_together/feature/home/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    final upper = RegExp(r'[A-Z]');
    final lower = RegExp(r'[a-z]');
    final digit = RegExp(r'\d');
    final special = RegExp(r'[!@#\$&*~]');
    if (!upper.hasMatch(value)) return 'Must include at least one uppercase';
    if (!lower.hasMatch(value)) return 'Must include at least one lowercase';
    if (!digit.hasMatch(value)) return 'Must include at least one digit';
    if (!special.hasMatch(value)) return 'Must include a special character (!@#\$&*~)';
    return null;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    ).then((userCredential) {
      // Successful login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome back, ${userCredential.user?.email}!')),
      );
      setState(() => _isLoading = false);

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((error) {
      // Handle login errors
      String errorMessage = 'Login failed. Please try again.';
      setState(() => _isLoading = false);
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'user-disabled':
            errorMessage = 'This user has been disabled.';
            break;
          default:
            errorMessage = error.message ?? errorMessage;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(blurRadius: 14.r, color: Colors.black12)],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome Back',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 22.sp,
                      )),
                  SizedBox(height: 24.h),

                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, size: 20.sp),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: _validateEmail,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 16.h),

                  // Password Input
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, size: 20.sp),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          size: 20.sp,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: _validatePassword,
                    style: TextStyle(fontSize: 16.sp),
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?', style: TextStyle(fontSize: 14.sp)),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(strokeWidth: 2.r),
                            )
                          : Text('Log In', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(fontSize: 13.sp)),
                      TextButton(
                        onPressed: () {},
                        child: Text('Sign Up', style: TextStyle(fontSize: 13.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
