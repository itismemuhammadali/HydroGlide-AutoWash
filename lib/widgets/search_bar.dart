import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onMicTap;

  const AppSearchBar({super.key, this.controller, this.onMicTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
        style: const TextStyle(fontSize: 15, color: AppColors.dark),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFAAAAAA)),
          suffixIcon: null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
