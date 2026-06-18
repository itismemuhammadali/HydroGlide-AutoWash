import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String role;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.role = 'Customer',
  });

  static const _customerItems = [
    (svg: 'assets/images/home.svg'),
    (svg: 'assets/images/booking.svg'),
    (svg: 'assets/images/profile.svg'),
    (svg: 'assets/images/notification.svg'),
  ];

  static const _employeeItems = [
    (svg: 'assets/images/home.svg'),
    (svg: 'assets/images/profile.svg'),
    (svg: 'assets/images/notification.svg'),
  ];

  static const _adminItems = [
    (svg: 'assets/images/home.svg'),
    (svg: 'assets/images/booking.svg'),
    (svg: 'assets/images/add_user.svg'),
    (svg: 'assets/images/profile.svg'),
    (svg: 'assets/images/notification.svg'),
  ];

  List<({String svg})> get _items {
    if (role == 'Admin') {
      return _adminItems;
    } else if (role == 'Employee') {
      return _employeeItems;
    } else {
      return _customerItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final isActive = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  _items[i].svg,
                  width: 32,
                  height: 32,
                  colorFilter: ColorFilter.mode(
                    isActive ? Colors.white : Colors.white54,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 3,
                  width: isActive ? 20 : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
