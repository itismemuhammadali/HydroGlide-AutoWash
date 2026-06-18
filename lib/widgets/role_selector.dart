import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RoleSelector extends StatefulWidget {
  final Function(String) onRoleSelected;
  final String initialRole;

  const RoleSelector({
    super.key,
    required this.onRoleSelected,
    this.initialRole = 'Employee',
  });

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  late String selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
  }

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
              onPressed: () {
                setState(() {
                  selectedRole = 'Admin';
                });
                widget.onRoleSelected('Admin');
              },
            ),
            const SizedBox(width: 12),
            _RoleButton(
              label: 'Employee',
              isSelected: selectedRole == 'Employee',
              onPressed: () {
                setState(() {
                  selectedRole = 'Employee';
                });
                widget.onRoleSelected('Employee');
              },
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.dark,
          ),
        ),
      ),
    );
  }
}
