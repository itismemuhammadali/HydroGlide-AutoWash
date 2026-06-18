import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/search_bar.dart';
import 'task_details_screen.dart';

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) => const EmployeeDashboardBody();
}

class EmployeeDashboardBody extends StatefulWidget {
  const EmployeeDashboardBody({super.key});

  @override
  State<EmployeeDashboardBody> createState() => _EmployeeDashboardBodyState();
}

class _EmployeeDashboardBodyState extends State<EmployeeDashboardBody> {
  String _selectedTab = 'Assigned';

  final List<_TaskItem> _allTasks = [
    _TaskItem(
      id: '#1234',
      status: 'Assigned',
      vehicle: 'Sedan - Toyota Camry',
      service: 'Exterior & Interior',
      location: 'Dubai Marina',
      time: '10:00 AM',
    ),
    _TaskItem(
      id: '#1235',
      status: 'Assigned',
      vehicle: 'SUV - Range Rover',
      service: 'Exterior Only',
      location: 'JBR',
      time: '11:30 AM',
    ),
    _TaskItem(
      id: '#1236',
      status: 'Active',
      vehicle: 'Sedan - BMW 3 Series',
      service: 'Exterior & Interior',
      location: 'Downtown Dubai',
      time: '02:00 PM',
    ),
    _TaskItem(
      id: '#1237',
      status: 'InProgress',
      vehicle: 'Pickup Truck - Ford F-150',
      service: 'Exterior Only',
      location: 'Business Bay',
      time: '09:00 AM',
    ),
    _TaskItem(
      id: '#1238',
      status: 'InReview',
      vehicle: 'Compact SUV - Honda CR-V',
      service: 'Exterior & Interior',
      location: 'Marina',
      time: '08:30 AM',
    ),
    _TaskItem(
      id: '#1239',
      status: 'Done',
      vehicle: 'Minivan - Toyota Sienna',
      service: 'Full Detailing',
      location: 'Al Baraha',
      time: '03:00 PM',
    ),
    _TaskItem(
      id: '#1240',
      status: 'Done',
      vehicle: 'Sedan - Mercedes C-Class',
      service: 'Interior Cleaning',
      location: 'Palm Jumeirah',
      time: '01:00 PM',
    ),
    _TaskItem(
      id: '#1241',
      status: 'Cancelled',
      vehicle: 'Full Size SUV - Cadillac Escalade',
      service: 'Exterior & Interior',
      location: 'Downtown',
      time: '04:00 PM',
    ),
    _TaskItem(
      id: '#1242',
      status: 'Unassigned',
      vehicle: 'Truck - Ford F-250',
      service: 'Exterior Only',
      location: 'Business Bay',
      time: '10:30 AM',
    ),
    _TaskItem(
      id: '#1243',
      status: 'Assigned',
      vehicle: 'Sedan - Audi A4',
      service: 'Exterior & Interior',
      location: 'JBR',
      time: '05:00 PM',
    ),
  ];

  List<_TaskItem> get _filteredTasks {
    return _allTasks.where((task) => task.status == _selectedTab).toList();
  }

  TaskStatus _getTaskStatus(String status) {
    switch (status) {
      case 'Assigned':
        return TaskStatus.newAssignment;
      case 'Active':
        return TaskStatus.active;
      case 'InProgress':
        return TaskStatus.active;
      case 'InReview':
        return TaskStatus.active;
      case 'Done':
        return TaskStatus.completed;
      case 'Cancelled':
        return TaskStatus.completed;
      case 'Unassigned':
        return TaskStatus.newAssignment;
      default:
        return TaskStatus.newAssignment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dashboard',
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
          const SizedBox(height: 12),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppSearchBar(),
          ),
          const SizedBox(height: 20),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Tasks',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome back, Ahmed',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tab selector
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _TabButton(
                            label: 'Assigned (${_allTasks.where((t) => t.status == 'Assigned').length})',
                            isSelected: _selectedTab == 'Assigned',
                            onTap: () => setState(() => _selectedTab = 'Assigned'),
                          ),
                          _TabButton(
                            label: 'Active (${_allTasks.where((t) => t.status == 'Active').length})',
                            isSelected: _selectedTab == 'Active',
                            onTap: () => setState(() => _selectedTab = 'Active'),
                          ),
                          _TabButton(
                            label: 'InProgress (${_allTasks.where((t) => t.status == 'InProgress').length})',
                            isSelected: _selectedTab == 'InProgress',
                            onTap: () => setState(() => _selectedTab = 'InProgress'),
                          ),
                          _TabButton(
                            label: 'InReview (${_allTasks.where((t) => t.status == 'InReview').length})',
                            isSelected: _selectedTab == 'InReview',
                            onTap: () => setState(() => _selectedTab = 'InReview'),
                          ),
                          _TabButton(
                            label: 'Done (${_allTasks.where((t) => t.status == 'Done').length})',
                            isSelected: _selectedTab == 'Done',
                            onTap: () => setState(() => _selectedTab = 'Done'),
                          ),
                          _TabButton(
                            label: 'Cancelled (${_allTasks.where((t) => t.status == 'Cancelled').length})',
                            isSelected: _selectedTab == 'Cancelled',
                            onTap: () => setState(() => _selectedTab = 'Cancelled'),
                          ),
                          _TabButton(
                            label: 'Unassigned (${_allTasks.where((t) => t.status == 'Unassigned').length})',
                            isSelected: _selectedTab == 'Unassigned',
                            onTap: () => setState(() => _selectedTab = 'Unassigned'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Task list
                  ..._filteredTasks.map((task) => Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TaskDetailsScreen(
                              status: _getTaskStatus(task.status),
                              taskId: task.id,
                              customerName: 'John Smith',
                              customerPhone: '+971 50 123 4567',
                              vehicleType: task.vehicle.split(' - ')[0],
                              vehicleMakeModel: task.vehicle.split(' - ')[1],
                              vehicleColor: 'Silver',
                              serviceType: task.service,
                              servicePrice: 500,
                              date: 'Jan 15, 2026',
                              time: task.time,
                              location: task.location,
                            ),
                          ),
                        ),
                        child: _TaskCard(task: task),
                      ),
                      const SizedBox(height: 12),
                    ],
                  )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.dark : const Color(0xFF999999),
              ),
            ),
          ),
        ),
      );
  }
}

class _TaskCard extends StatelessWidget {
  final _TaskItem task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task ID and status
          Row(
            children: [
              Text(
                task.id,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Vehicle info
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/car_right_side.svg',
                width: 13,
                height: 13,
                colorFilter: const ColorFilter.mode(Color(0xFF666666), BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.vehicle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.service,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 15),
          // Location and time
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/location_arrow.svg',
                width: 13,
                height: 13,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.location,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/clock.svg',
                width: 13,
                height: 13,
              ),
              const SizedBox(width: 8),
              Text(
                task.time,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskItem {
  final String id;
  final String status;
  final String vehicle;
  final String service;
  final String location;
  final String time;

  _TaskItem({
    required this.id,
    required this.status,
    required this.vehicle,
    required this.service,
    required this.location,
    required this.time,
  });
}
