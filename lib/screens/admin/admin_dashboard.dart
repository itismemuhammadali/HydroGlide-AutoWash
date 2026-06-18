import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/payment_card.dart';
import 'payment_overview_screen.dart';
import 'admin_bookings_screen.dart';
import 'admin_booking_details_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) => const AdminDashboardBody();
}

class AdminDashboardBody extends StatefulWidget {
  const AdminDashboardBody({super.key});

  @override
  State<AdminDashboardBody> createState() => _AdminDashboardBodyState();
}

class _AdminDashboardBodyState extends State<AdminDashboardBody> {
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
              padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).padding.bottom + 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Details Section
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminBookingsScreen(
                                showBackButton: true,
                                filterType: 'all',
                              ),
                            ),
                          ),
                          child: _StatCard(
                            icon: Icons.trending_up,
                            value: '248',
                            label: 'Total\nBookings',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminBookingsScreen(
                                showBackButton: true,
                                filterType: 'active',
                              ),
                            ),
                          ),
                          child: _StatCard(
                            icon: Icons.schedule,
                            value: '12',
                            label: 'Active\nOrders',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminBookingsScreen(
                                showBackButton: true,
                                filterType: 'completed',
                              ),
                            ),
                          ),
                          child: _StatCard(
                            svgPath: 'assets/images/border_tick_outline.svg',
                            value: '236',
                            label: 'Orders\nCompleted',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Payment Overview
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Payment Overview',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const PaymentOverviewScreen(),
                          ),
                        ),
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        PaymentCard(
                          label: 'Total Revenue',
                          value: '\$5,000',
                        ),
                        SizedBox(width: 12),
                        PaymentCard(
                          label: 'Paid Bookings',
                          value: '32',
                        ),
                        SizedBox(width: 12),
                        PaymentCard(
                          label: 'Pending Payments',
                          value: '12',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Recent Bookings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Bookings',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AdminBookingsScreen(showBackButton: true),
                          ),
                        ),
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#1243',
                    service: 'Exterior Only',
                    status: 'Active',
                    statusColor: const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#1345',
                    service: 'Exterior & Interior',
                    status: 'Completed',
                    statusColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#2331',
                    service: 'Exterior & Interior',
                    status: 'Pending',
                    statusColor: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#3115',
                    service: 'Exterior Only',
                    status: 'Pending',
                    statusColor: const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#4201',
                    service: 'Full Detailing',
                    status: 'Cancelled',
                    statusColor: const Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#4302',
                    service: 'Exterior Only',
                    status: 'Unassigned',
                    statusColor: const Color(0xFF6B7280),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#4403',
                    service: 'Interior Cleaning',
                    status: 'Cancelled',
                    statusColor: const Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 12),
                  _BookingCard(
                    bookingId: '#4504',
                    service: 'Exterior & Interior',
                    status: 'Unassigned',
                    statusColor: const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final String value;
  final String label;

  const _StatCard({
    this.icon,
    this.svgPath,
    required this.value,
    required this.label,
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
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: svgPath != null
                ? Center(
                    child: SvgPicture.asset(
                      svgPath!,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  )
                : Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF999999),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String bookingId;
  final String service;
  final String status;
  final Color statusColor;

  const _BookingCard({
    required this.bookingId,
    required this.service,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AdminBookingDetailsScreen(
              bookingId: bookingId,
              status: status,
              customerName: 'Customer',
              customerPhone: '+971 50 123 4567',
              customerEmail: 'customer@example.com',
              vehicleType: 'Sedan',
              vehicleMakeModel: 'Toyota Camry',
              vehicleColor: 'Silver',
              serviceType: service,
              servicePrice: 500,
              date: 'Jan 15, 2026',
              time: '10:00 AM',
              location: '123 Main St.',
            ),
          ),
        );
      },
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingId,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                border: Border.all(color: statusColor, width: 1),
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
      ),
    );
  }
}
