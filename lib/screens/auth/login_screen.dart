import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/login_header.dart';
import 'customer/signup_screen.dart';
import '../shell/app_shell.dart';
import 'forgot_password_screen.dart';
import '../onboarding/onboarding_screen.dart';

class LoginScreen extends StatefulWidget {
  final String role;
  const LoginScreen({super.key, this.role = 'Customer'});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late String _displayedRole;
  bool _showRoleSelector = false;

  @override
  void initState() {
    super.initState();
    _displayedRole = 'Customer'; // Default displayed role
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: IconButton(
                icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    // Login header with clickable icon or admin shield
                    if (_showRoleSelector && _displayedRole == 'Admin')
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showRoleSelector = !_showRoleSelector;
                          });
                        },
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/admin_login_shield.svg',
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showRoleSelector = !_showRoleSelector;
                            // When opening role selector, switch to Admin if currently on Customer
                            if (_showRoleSelector && _displayedRole == 'Customer') {
                              _displayedRole = 'Admin';
                            }
                          });
                        },
                        child: LoginHeader(
                          title: 'Login',
                          iconPath: 'assets/images/person.svg',
                        ),
                      ),
                    const SizedBox(height: 36),
                    // Role selector - only show when icon is clicked
                    if (_showRoleSelector)
                      Column(
                        children: [
                          _RoleSelectorButtons(
                            selectedRole: _displayedRole,
                            onRoleSelected: (role) {
                              setState(() {
                                _displayedRole = role;
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    // Email field
                    _InputField(
                      label: 'Email',
                      hint: 'user@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    // Password field
                    _InputField(
                      label: 'Password',
                      hint: '••••••••••',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    // Forgot Password button - aligned to right
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                        ),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Sign In button
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Sign In',
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => AppShell(role: _displayedRole),
                          ),
                        ),
                        backgroundColor: AppColors.dark,
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Create account - only show when role selector is not open
                    if (!_showRoleSelector)
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              text: 'New here? ',
                              style: TextStyle(color: AppColors.grey, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Create account',
                                  style: TextStyle(color: AppColors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15, color: AppColors.dark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class _RoleSelectorButtons extends StatelessWidget {
  final String selectedRole;
  final Function(String) onRoleSelected;

  const _RoleSelectorButtons({
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Select your role',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RoleButton(
              label: 'Admin',
              isSelected: selectedRole == 'Admin',
              onPressed: () => onRoleSelected('Admin'),
            ),
            const SizedBox(width: 12),
            _RoleButton(
              label: 'Employee',
              isSelected: selectedRole == 'Employee',
              onPressed: () => onRoleSelected('Employee'),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _RoleButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.dark : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.dark : const Color(0xFFDDDDDD),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.dark,
          ),
        ),
      ),
    );
  }
}
