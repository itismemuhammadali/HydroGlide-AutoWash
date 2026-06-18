import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validation
    if (currentPassword.isEmpty) {
      _showError('Please enter your current password');
      return;
    }
    if (newPassword.isEmpty) {
      _showError('Please enter a new password');
      return;
    }
    if (confirmPassword.isEmpty) {
      _showError('Please confirm your new password');
      return;
    }
    if (newPassword != confirmPassword) {
      _showError('New passwords do not match');
      return;
    }
    if (newPassword.length < 8) {
      _showError('Password must be at least 8 characters');
      return;
    }
    if (currentPassword == newPassword) {
      _showError('New password must be different from current password');
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Implement password change with your auth provider
    // This is where you'll call your authentication service
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: Color(0xFF10B981),
          ),
        );
        Navigator.of(context).pop();
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark,
                      height: 1.29,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Current Password
                    _PasswordField(
                      label: 'Current Password',
                      controller: _currentPasswordController,
                      isVisible: _showCurrentPassword,
                      onVisibilityToggle: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
                    ),
                    const SizedBox(height: 16),
                    // New Password
                    _PasswordField(
                      label: 'New Password',
                      controller: _newPasswordController,
                      isVisible: _showNewPassword,
                      onVisibilityToggle: () => setState(() => _showNewPassword = !_showNewPassword),
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password
                    _PasswordField(
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      isVisible: _showConfirmPassword,
                      onVisibilityToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                    ),
                    const SizedBox(height: 32),
                    // Change Password Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dark,
                          disabledBackgroundColor: Colors.grey.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Change Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onVisibilityToggle;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.isVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: GestureDetector(
            onTap: onVisibilityToggle,
            child: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.grey,
              size: 20,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
      ),
    );
  }
}
