import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'task_assigned_screen.dart';

class EmployeeItem {
  final String name;
  final String role;
  final double rating;
  final int completed;
  final bool available;

  const EmployeeItem({
    required this.name,
    required this.role,
    required this.rating,
    required this.completed,
    required this.available,
  });
}

class AssignEmployeeScreen extends StatefulWidget {
  final String bookingId;
  final String customerName;
  final String location;
  final String vehicle;
  final String time;
  final String? customerPhone;
  final String? customerEmail;
  final String? vehicleMakeModel;
  final String? vehicleColor;
  final String? serviceType;
  final double? servicePrice;
  final String? date;

  const AssignEmployeeScreen({
    super.key,
    required this.bookingId,
    required this.customerName,
    required this.location,
    required this.vehicle,
    required this.time,
    this.customerPhone,
    this.customerEmail,
    this.vehicleMakeModel,
    this.vehicleColor,
    this.serviceType,
    this.servicePrice,
    this.date,
  });

  @override
  State<AssignEmployeeScreen> createState() => _AssignEmployeeScreenState();
}

class _AssignEmployeeScreenState extends State<AssignEmployeeScreen> {
  int? _selectedEmployeeIndex;

  final List<EmployeeItem> employees = const [
    EmployeeItem(
      name: 'Ahmed AL-Mansoori',
      role: 'Senior Detailer',
      rating: 4.8,
      completed: 12,
      available: true,
    ),
    EmployeeItem(
      name: 'Muhammad Hassan',
      role: 'Wash Specialist',
      rating: 4.9,
      completed: 17,
      available: true,
    ),
    EmployeeItem(
      name: 'Rashid Ali',
      role: 'Junior Detailer',
      rating: 4.5,
      completed: 10,
      available: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Assign Employee',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                          height: 1.29,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Booking Details Card
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Booking Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.dark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _DetailRow(label: 'Customer', value: widget.customerName),
                          const SizedBox(height: 12),
                          _DetailRow(label: 'Location', value: widget.location),
                          const SizedBox(height: 12),
                          _DetailRow(label: 'Vehicle', value: widget.vehicle),
                          const SizedBox(height: 12),
                          _DetailRow(label: 'Time', value: widget.time),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Select Employee
                    const Text(
                      'Select Employee',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Employee List
                    ...employees.asMap().entries.map((entry) {
                      final index = entry.key;
                      final employee = entry.value;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedEmployeeIndex = index),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: _selectedEmployeeIndex == index
                                    ? Border.all(color: AppColors.dark, width: 2)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F4F6),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.person_outline,
                                          color: Color(0xFF1A1A1A),
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              employee.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.dark,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              employee.role,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF999999),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.star, color: Color(0xFFFCD34D), size: 18),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        employee.rating.toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.dark,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Text(
                                                          '${employee.completed} Completed',
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xFF999999),
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFB3FF66),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: const Text(
                                                    'Available',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFF1A1A1A),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_selectedEmployeeIndex == index)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: AppColors.dark,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    }),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            // Assign Task Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedEmployeeIndex != null
                      ? () {
                          final selectedEmployee = employees[_selectedEmployeeIndex!];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TaskAssignedScreen(
                                employeeName: selectedEmployee.name,
                                employeeRole: selectedEmployee.role,
                                employeeRating: selectedEmployee.rating,
                                employeeCompleted: selectedEmployee.completed,
                                bookingId: widget.bookingId,
                                customerName: widget.customerName,
                                serviceType: widget.serviceType ?? 'Service Type',
                                customerPhone: widget.customerPhone,
                                customerEmail: widget.customerEmail,
                                vehicleType: widget.vehicle,
                                vehicleMakeModel: widget.vehicleMakeModel,
                                vehicleColor: widget.vehicleColor,
                                servicePrice: widget.servicePrice,
                                date: widget.date,
                                time: widget.time,
                                location: widget.location,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedEmployeeIndex != null ? AppColors.dark : const Color(0xFFD1D5DB),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Assign Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF999999),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }
}
