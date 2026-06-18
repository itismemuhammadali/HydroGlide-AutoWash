import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../employee/employee_dashboard.dart';
import '../admin/admin_dashboard.dart';
import '../admin/admin_bookings_screen.dart';
import '../admin/create_user_screen.dart';
import '../booking_management/my_bookings_screen.dart';
import '../profile/profile_screen.dart';
import '../notifications/notifications_screen.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;
  final String role;
  const AppShell({super.key, this.initialIndex = 0, this.role = 'Customer'});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;

  late final List<Widget> _customerScreens;
  late final List<Widget> _employeeScreens;
  late final List<Widget> _adminScreens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    
    _customerScreens = [
      const HomeBody(),
      const MyBookingsBody(),
      const ProfileBody(),
      const NotificationsBody(),
    ];

    _employeeScreens = [
      const EmployeeDashboardBody(),
      const ProfileBody(),
      const NotificationsBody(),
    ];

    _adminScreens = [
      const AdminDashboardBody(),
      const AdminBookingsScreen(),
      const CreateUserScreen(),
      const ProfileBody(),
      const NotificationsBody(),
    ];
  }

  List<Widget> get _screens {
    if (widget.role == 'Employee') {
      return _employeeScreens;
    } else if (widget.role == 'Admin') {
      return _adminScreens;
    } else {
      return _customerScreens;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: AppBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              role: widget.role,
            ),
          ),
        ],
      ),
    );
  }
}
