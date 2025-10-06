import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turf_together/feature/bottomNav/bottom_nav_bar.dart';
import 'package:turf_together/common/snackbar/snackbar.dart';
import 'package:turf_together/feature/auth/controller/auth_controller.dart';
import 'package:turf_together/feature/auth/model/user_model.dart';

// Main SignUp Flow Widget
class SignUpFlow extends ConsumerStatefulWidget {
  const SignUpFlow({super.key});

  @override
  ConsumerState<SignUpFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends ConsumerState<SignUpFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final UserModel _userData = UserModel(
    id: '',
    email: '',
    selectedSports: [],
    username: '',
    isOAuthSignUp: false,
    profileImage: null,
  );

  // Navigation methods
  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      _completeSignUp();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  void _completeSignUp() {
    log(
      'User Data: ${_userData.username}, ${_userData.email}, Sports: ${_userData.selectedSports.length}',
    );
    ref.read(userNotifierProvider.notifier).setUserDetails(_userData);

    UserModel finalUser = ref.read(userNotifierProvider);
    log(
      'Final User from Provider: ${finalUser.username}, ${finalUser.email}, Sports: ${finalUser.selectedSports.length}',
    );

    // Navigate to home screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentPage > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
                onPressed: _previousPage,
              )
            : null,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          //   child: LinearProgressIndicator(
          //     value: (_currentPage + 1) / 5,
          //     backgroundColor: Colors.grey.shade200,
          //     valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          //   ),
          // ),

          // Page Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AuthMethodScreen(userData: _userData, onNext: _nextPage),
                SportsSelectionScreen(userData: _userData, onNext: _nextPage),
                SportDetailsScreen(userData: _userData, onNext: _nextPage),
                UsernameScreen(userData: _userData, onNext: _nextPage),
                ProfilePictureScreen(userData: _userData, onNext: _nextPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Screen 1: Authentication Method Selection
class AuthMethodScreen extends StatefulWidget {
  final UserModel userData;
  final VoidCallback onNext;

  const AuthMethodScreen({
    super.key,
    required this.userData,
    required this.onNext,
  });

  @override
  State<AuthMethodScreen> createState() => _AuthMethodScreenState();
}

class _AuthMethodScreenState extends State<AuthMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEmailMethod = false;
  bool _obscurePassword = true;
  bool isSignedUp = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create your account',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose how you\'d like to sign up',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 40.h),

          Spacer(),

          // OAuth Options
          if (!_isEmailMethod) ...[
            _buildOAuthButton('Google', Icons.g_mobiledata, Colors.red),
            SizedBox(height: 28.h),

            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'or',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),
            SizedBox(height: 28.h),

            // Email signup button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _isEmailMethod = true),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Sign up with Email',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ],

          // Email Form
          if (_isEmailMethod) ...[
            // Login
            if (isSignedUp) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                  onPressed: () => setState(() => _isEmailMethod = false),
                  tooltip: 'Back',
                ),
              ),
              SizedBox(height: 16.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (context, ref, child) => ElevatedButton(
                          onPressed: () => _handleEmailSignIn(ref),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isSignedUp = false;
                          });
                        },
                        child: Text(
                          'No account',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Create Account
            if (!isSignedUp) ...[
              Padding(
                padding: EdgeInsets.all(16.sp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24.sp,
                          ),
                          onPressed: () => setState(() {
                            _isEmailMethod = false;
                            isSignedUp = true;
                          }),
                          tooltip: 'Back',
                        ),
                      ),
                      // Email input
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Password input
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Confirm password input
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      // Sign up button
                      SizedBox(
                        width: double.infinity,
                        child: Consumer(
                          builder: (context, ref, child) => ElevatedButton(
                            onPressed: () {
                              _handleEmailSignUp(ref);
                            },
                            child: const Text('Sign Up'),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isSignedUp = true;
                            });
                          },
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildOAuthButton(String provider, IconData icon, Color color) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _handleOAuthSignUp(provider),
        icon: Icon(icon, color: color),
        label: Text('Continue with $provider'),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  void _handleOAuthSignUp(String provider) {
    // TODO: Implement OAuth sign up logic
    widget.userData.isOAuthSignUp = true;

    widget.userData.email = 'google@gmail.com';

    widget.onNext();
  }

  Future<void> _handleEmailSignIn(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      widget.userData.isOAuthSignUp = false;

      final authController = ref.read(authControllerProvider);

      final signInData = await authController.signInWithEmail(
        email,
        password,
        context,
      );

      if (signInData is UserCredential) {
        widget.userData.email = email;
        widget.userData.id = signInData.user?.uid ?? '';

        context.showSuccessMessage('Signed in as $email');

        widget.onNext();
      }
    }
  }

  Future<void> _handleEmailSignUp(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      widget.userData.isOAuthSignUp = false;
      widget.userData.email = email;

      final authController = ref.read(authControllerProvider);
      final signUpData = await authController.signUpWithEmail(
        email,
        _passwordController.text.trim(),
        context,
      );
      if (signUpData != null) {
        widget.userData.id = signUpData.user?.uid ?? '';
        widget.onNext();
      }
    }
  }
}

// Screen 2: Sports Selection
class SportsSelectionScreen extends StatefulWidget {
  final UserModel userData;
  final VoidCallback onNext;

  const SportsSelectionScreen({
    super.key,
    required this.userData,
    required this.onNext,
  });

  @override
  State<SportsSelectionScreen> createState() => _SportsSelectionScreenState();
}

class _SportsSelectionScreenState extends State<SportsSelectionScreen> {
  final List<String> _availableSports = [
    'Cricket',
    'Badminton',
    'Football',
    'Tennis',
    'Basketball',
  ];

  final Map<String, IconData> _sportsIcons = {
    'Cricket': Icons.sports_cricket,
    'Badminton': Icons.sports_tennis,
    'Football': Icons.sports_soccer,
    'Tennis': Icons.sports_tennis,
    'Basketball': Icons.sports_basketball,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What sports interest you?',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Select all that apply',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 40.h),

          // Sports Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.2,
              ),
              itemCount: _availableSports.length,
              itemBuilder: (context, index) {
                final sport = _availableSports[index];
                final isSelected = widget.userData.selectedSports.contains(
                  sport,
                );

                return GestureDetector(
                  onTap: () => _toggleSport(sport),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _sportsIcons[sport]!,
                          size: 40.sp,
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade600,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          sport,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.blue : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: widget.userData.selectedSports.isNotEmpty
                    ? widget.onNext
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Continue (${widget.userData.selectedSports.length} selected)',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSport(String sport) {
    setState(() {
      if (widget.userData.selectedSports.contains(sport)) {
        widget.userData.selectedSports.remove(sport);
        widget.userData.sportDetails.remove(sport);
      } else {
        widget.userData.selectedSports.add(sport);
      }
    });
  }
}

// Screen 3: Sport Details (Age and Skill Level)
class SportDetailsScreen extends StatefulWidget {
  final UserModel userData;
  final VoidCallback onNext;

  const SportDetailsScreen({
    super.key,
    required this.userData,
    required this.onNext,
  });

  @override
  State<SportDetailsScreen> createState() => _SportDetailsScreenState();
}

class _SportDetailsScreenState extends State<SportDetailsScreen> {
  final List<String> _skillLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize sport details if not already done
    for (String sport in widget.userData.selectedSports) {
      if (!widget.userData.sportDetails.containsKey(sport)) {
        widget.userData.sportDetails[sport] = SportDetails(
          age: 18,
          skillLevel: 'Beginner',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about your experience',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Age and skill level for each sport',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 32.h),

          // Sport Details List
          Expanded(
            child: ListView.builder(
              itemCount: widget.userData.selectedSports.length,
              itemBuilder: (context, index) {
                final sport = widget.userData.selectedSports[index];
                final details = widget.userData.sportDetails[sport]!;

                return Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sport,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Age Slider
                      Text(
                        'Age: ${details.age}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Slider(
                        value: details.age.toDouble(),
                        min: 10,
                        max: 80,
                        divisions: 70,
                        onChanged: (value) {
                          setState(() {
                            details.age = value.toInt();
                          });
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Skill Level
                      Text(
                        'Skill Level',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        children: _skillLevels.map((skill) {
                          final isSelected = details.skillLevel == skill;
                          return ChoiceChip(
                            label: Text(skill),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  details.skillLevel = skill;
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onNext,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Continue', style: TextStyle(fontSize: 16.sp)),
            ),
          ),
        ],
      ),
    );
  }
}

// Screen 4: Username
class UsernameScreen extends StatefulWidget {
  final UserModel userData;
  final VoidCallback onNext;

  const UsernameScreen({
    super.key,
    required this.userData,
    required this.onNext,
  });

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose a username',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This will be your unique identifier',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 40.h),

          Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: const Icon(Icons.alternate_email),
                helperText: 'Must be 3-20 characters, letters and numbers only',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                if (value.length > 20) {
                  return 'Username must be less than 20 characters';
                }
                if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                  return 'Username can only contain letters, numbers, and underscores';
                }
                return null;
              },
            ),
          ),

          const Spacer(),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Continue', style: TextStyle(fontSize: 16.sp)),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      widget.userData.username = _usernameController.text;
      widget.onNext();
    }
  }
}

// Screen 5: Profile Picture
class ProfilePictureScreen extends StatefulWidget {
  final UserModel userData;
  final VoidCallback onNext;

  const ProfilePictureScreen({
    super.key,
    required this.userData,
    required this.onNext,
  });

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a profile picture',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This helps others recognize you (optional)',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 40.h),

          // Profile Picture Container
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  color: Colors.grey.shade100,
                ),
                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      )
                    : Icon(
                        Icons.add_a_photo,
                        size: 40.sp,
                        color: Colors.grey.shade600,
                      ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          if (widget.userData.profileImage == null)
            Center(
              child: TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Choose Photo'),
              ),
            ),

          if (widget.userData.profileImage != null)
            Center(
              child: TextButton.icon(
                onPressed: _removeImage,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove Photo'),
              ),
            ),

          const Spacer(),

          // Action Buttons
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Complete Sign Up',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),

              if (imageFile == null) ...[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: widget.onNext,
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<File?> _compressImage(File file) async {
    final targetPath =
        '${file.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final XFile? compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      minWidth: 800,
      minHeight: 800,
    );

    return compressed != null ? File(compressed.path) : null;
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );

      if (pickedFile != null) {
        File originalFile = File(pickedFile.path);

        // Compress for DB efficiency
        File? compressedFile = await _compressImage(originalFile);

        if (compressedFile != null) {
          setState(() {
            imageFile = compressedFile;
          });
        } else {
          context.showErrorMessage("Image compression failed");
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error picking image: $e")));
    }
  }

  void _removeImage() {
    setState(() {
      widget.userData.profileImage = null;
    });
  }
}
