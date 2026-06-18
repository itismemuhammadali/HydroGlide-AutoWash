import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PaymentOverviewScreen extends StatelessWidget {
  const PaymentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF2F2F2),
    body: const PaymentOverviewBody(),
  );
}

class PaymentOverviewBody extends StatelessWidget {
  const PaymentOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      'Payment Overview',
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
                  const Text(
                    'Recent Payments',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _PaymentItem(
                    bookingId: '#1234',
                    customerName: 'John Smith',
                    service: 'Exterior & Interior',
                    vehicleType: 'Vehicle Type: Sedan',
                    amount: '500 AED',
                    status: 'Paid',
                    statusColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 12),
                  _PaymentItem(
                    bookingId: '#3250',
                    customerName: 'Sara Johnson',
                    service: 'Exterior Only',
                    vehicleType: 'Vehicle Type: Sedan',
                    amount: '165 AED',
                    status: 'Pending',
                    statusColor: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 12),
                  _PaymentItem(
                    bookingId: '#1670',
                    customerName: 'Thomas Shelby',
                    service: 'Exterior & Interior',
                    vehicleType: 'Vehicle Type: Compact SUV',
                    amount: '650 AED',
                    status: 'Paid',
                    statusColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 12),
                  _PaymentItem(
                    bookingId: '#1234',
                    customerName: 'Walter White',
                    service: 'Exterior & Interior',
                    vehicleType: 'Vehicle Type: Pickup Truck',
                    amount: '800 AED',
                    status: 'Pending',
                    statusColor: const Color(0xFFF59E0B),
                  ),
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

class _PaymentItem extends StatelessWidget {
  final String bookingId;
  final String customerName;
  final String service;
  final String vehicleType;
  final String amount;
  final String status;
  final Color statusColor;

  const _PaymentItem({
    required this.bookingId,
    required this.customerName,
    required this.service,
    required this.vehicleType,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bookingId,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            customerName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFFAAAAAA),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vehicleType,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFFAAAAAA),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}
