import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import '../shell/app_shell.dart';

class BookingReviewResultScreen extends StatelessWidget {
  final bool isApproved;
  final String bookingId;

  const BookingReviewResultScreen({
    super.key,
    required this.isApproved,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Result icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: isApproved
                              ? const Color(0xFFD4F5E0)
                              : const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: Icon(
                            isApproved ? Icons.check_circle : Icons.cancel,
                            size: 60,
                            color: isApproved
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Result title
                      Text(
                        isApproved ? 'Booking Approved' : 'Booking Rejected',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Result message
                      Text(
                        isApproved
                            ? 'The booking has been approved successfully.\nCustomer has been notified.'
                            : 'The booking has been rejected.\nCustomer has been notified.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Booking ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFEEEEEE),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Booking ID: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF999999),
                              ),
                            ),
                            Text(
                              bookingId,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Action button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Back to Dashboard',
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const AppShell(role: 'Admin'),
                    ),
                  ),
                  backgroundColor: AppColors.dark,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
