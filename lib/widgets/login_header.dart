import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String iconPath;
  final double iconSize;
  final double boxSize;

  const LoginHeader({
    super.key,
    required this.title,
    required this.iconPath,
    this.iconSize = 80,
    this.boxSize = 140,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: boxSize,
          height: boxSize,
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
              iconPath,
              width: iconSize,
              height: iconSize,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }
}
