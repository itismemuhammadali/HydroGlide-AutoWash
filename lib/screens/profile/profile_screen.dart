import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/edit_profile_sheet.dart';
import 'change_password_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => const ProfileBody();
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.dark,
                height: 1.29,
              )),
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 52, color: Colors.white),
          ),
          const SizedBox(height: 14),
          const Text('John Smith',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.dark)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 3)),
              ],
            ),
            child: TextButton.icon(
              onPressed: () => showEditProfileSheet(context),
              icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.dark),
              label: const Text('Edit profile',
                  style: TextStyle(fontSize: 20, color: AppColors.dark, fontWeight: FontWeight.w500)),
              iconAlignment: IconAlignment.end,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 150),
              children: [
                _ProfileField(svgPath: 'assets/images/profile(2).svg', label: 'Username', value: 'John Smith'),
                const SizedBox(height: 12),
                _ProfileField(icon: Icons.phone, label: 'Contact Number', value: '+ 234 567 8900'),
                const SizedBox(height: 12),
                _ProfileField(svgPath: 'assets/images/email.svg', label: 'Email', value: 'johnsmith1212@gmail.com'),
                const SizedBox(height: 12),
                _ProfileField(icon: Icons.lock, label: 'Password', value: '••••••••••••'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final String label;
  final String value;

  const _ProfileField({
    this.icon,
    this.svgPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          if (svgPath != null)
            SvgPicture.asset(
              svgPath!,
              width: 25,
              height: 25,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            )
          else
            Icon(icon, color: Colors.black, size: 30),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.dark)),
            ],
          ),
        ],
      ),
    );
  }
}
