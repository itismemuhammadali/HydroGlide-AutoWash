import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'my_bookings_screen.dart';
import '../admin/booking_review_result_screen.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingItem booking;
  final bool isAdminReview;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const BookingDetailsScreen({
    super.key,
    required this.booking,
    this.isAdminReview = false,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(isAdminReview ? 'Review Booking' : 'Booking Details',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.dark,
                        height: 1.29,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Status banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isAdminReview ? 'Awaiting Approval' : _statusLabel(booking.status),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isAdminReview ? const Color(0xFFFFA500) : _statusColor(booking.status),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Service Photos
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Service Photos',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _PhotoBox(label: 'Before', isSelected: false),
                              const SizedBox(width: 12),
                              _PhotoBox(label: 'After', isSelected: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Completed by
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Completed by:',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          SizedBox(height: 14),
                          _InfoRow(label: 'Employee', value: 'Ahmed Al-Mansoori'),
                          Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(label: 'Role', value: 'Senior Detailer'),
                          Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(label: 'Time Taken', value: '42 Minutes'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Service Summary
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Service Summary',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          const SizedBox(height: 14),
                          _InfoRow(label: 'Service', value: booking.service),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          const _InfoRow(label: 'Vehicle', value: 'Sedan'),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          const _InfoRow(label: 'Customer', value: 'John Smith'),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(
                            label: 'Amount',
                            value: '${booking.amount.toStringAsFixed(0)} AED',
                            valueColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Admin action buttons
            if (isAdminReview)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => BookingReviewResultScreen(
                                isApproved: true,
                                bookingId: booking.bookingId,
                              ),
                            ),
                          );
                          onApprove?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dark,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Approve & Notify Customer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => BookingReviewResultScreen(
                                isApproved: false,
                                bookingId: booking.bookingId,
                              ),
                            ),
                          );
                          onReject?.call();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.dark, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close, color: AppColors.dark, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Reject Completion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
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

  String _statusLabel(BookingStatus status) => switch (status) {
        BookingStatus.pending => 'Pending',
        BookingStatus.active => 'Active',
        BookingStatus.inProgress => 'In Progress',
        BookingStatus.inReview => 'In Review',
        BookingStatus.completed => 'Completed',
        BookingStatus.cancelled => 'Cancelled',
        BookingStatus.unassigned => 'Unassigned',
      };

  Color _statusColor(BookingStatus status) => switch (status) {
        BookingStatus.pending => const Color(0xFFF59E0B),
        BookingStatus.active => const Color(0xFF047857),
        BookingStatus.inProgress => const Color(0xFF3B82F6),
        BookingStatus.inReview => const Color(0xFFBE185D),
        BookingStatus.completed => const Color(0xFF10B981),
        BookingStatus.cancelled => const Color(0xFFEF4444),
        BookingStatus.unassigned => const Color(0xFF6B7280),
      };
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.grey)),
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: valueColor ?? AppColors.dark)),
      ],
    );
  }
}

class _PhotoBox extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _PhotoBox({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: AppColors.dark, width: 2) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 28, color: AppColors.grey),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.dark, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
