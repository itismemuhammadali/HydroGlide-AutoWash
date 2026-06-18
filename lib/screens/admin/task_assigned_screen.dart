import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'admin_booking_details_screen.dart';

class TaskAssignedScreen extends StatelessWidget {
  final String employeeName;
  final String employeeRole;
  final double employeeRating;
  final int employeeCompleted;
  final String bookingId;
  final String customerName;
  final String serviceType;
  final String? customerPhone;
  final String? customerEmail;
  final String? vehicleType;
  final String? vehicleMakeModel;
  final String? vehicleColor;
  final double? servicePrice;
  final String? date;
  final String? time;
  final String? location;

  const TaskAssignedScreen({
    super.key,
    required this.employeeName,
    required this.employeeRole,
    required this.employeeRating,
    required this.employeeCompleted,
    required this.bookingId,
    required this.customerName,
    required this.serviceType,
    this.customerPhone,
    this.customerEmail,
    this.vehicleType,
    this.vehicleMakeModel,
    this.vehicleColor,
    this.servicePrice,
    this.date,
    this.time,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    children: [
                      // Success Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Success Message
                      const Text(
                        'Task Assigned Successfully!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'The task has been assigned to the employee',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF999999),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Employee Details Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                              'Assigned To',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const SizedBox(height: 16),
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
                                        employeeName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.dark,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        employeeRole,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF999999),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Color(0xFFFCD34D), size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                            employeeRating.toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            '$employeeCompleted Completed',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF999999),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Task Details Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                              'Task Details',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _DetailRow(label: 'Booking ID', value: bookingId),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFEEEEEE)),
                            const SizedBox(height: 12),
                            _DetailRow(label: 'Customer', value: customerName),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFEEEEEE)),
                            const SizedBox(height: 12),
                            _DetailRow(label: 'Service', value: serviceType),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Pop back to admin dashboard
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dark,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Dashboard',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AdminBookingDetailsScreen(
                            bookingId: bookingId,
                            status: 'Assigned',
                            customerName: customerName,
                            customerPhone: customerPhone ?? '+971 50 123 4567',
                            customerEmail: customerEmail ?? 'customer@example.com',
                            vehicleType: vehicleType ?? 'Sedan',
                            vehicleMakeModel: vehicleMakeModel ?? 'Toyota Camry',
                            vehicleColor: vehicleColor ?? 'Silver',
                            serviceType: serviceType,
                            servicePrice: servicePrice ?? 500,
                            date: date ?? 'Jan 15, 2026',
                            time: time ?? '10:00 AM',
                            location: location ?? '123 Main St.',
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.dark, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'View Booking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  ),
                ],
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
