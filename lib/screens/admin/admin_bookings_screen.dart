import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'admin_booking_details_screen.dart';
import '../booking_management/booking_details_screen.dart';
import '../booking_management/my_bookings_screen.dart';

enum AdminBookingStatus { pending, active, inProgress, inReview, completed, cancelled, unassigned }

class AdminBookingItem {
  final String bookingId;
  final String vehicle;
  final String service;
  final AdminBookingStatus status;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String vehicleMakeModel;
  final String vehicleColor;
  final double servicePrice;
  final String date;
  final String time;
  final String location;

  const AdminBookingItem({
    required this.bookingId,
    required this.vehicle,
    required this.service,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.vehicleMakeModel,
    required this.vehicleColor,
    required this.servicePrice,
    required this.date,
    required this.time,
    required this.location,
  });
}

class AdminBookingsScreen extends StatelessWidget {
  final bool showBackButton;
  final String? filterType; // 'all', 'active', 'completed'
  const AdminBookingsScreen({
    super.key,
    this.showBackButton = false,
    this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    // If showBackButton is true, wrap with Scaffold (for navigation)
    // Otherwise, return body directly (for nav bar)
    if (showBackButton) {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: AdminBookingsBody(
          showBackButton: showBackButton,
          filterType: filterType,
        ),
      );
    }
    return AdminBookingsBody(
      showBackButton: showBackButton,
      filterType: filterType,
    );
  }
}

class AdminBookingsBody extends StatefulWidget {
  final bool showBackButton;
  final String? filterType;
  const AdminBookingsBody({
    super.key,
    this.showBackButton = false,
    this.filterType,
  });

  @override
  State<AdminBookingsBody> createState() => _AdminBookingsBodyState();
}

class _AdminBookingsBodyState extends State<AdminBookingsBody> {
  late final List<AdminBookingItem> bookings;

  @override
  void initState() {
    super.initState();
    bookings = const [
    AdminBookingItem(
      bookingId: '#1234',
      vehicle: 'Sedan',
      service: 'Exterior & Interior',
      status: AdminBookingStatus.pending,
      customerName: 'John Smith',
      customerPhone: '+971 50 123 4567',
      customerEmail: 'john@example.com',
      vehicleMakeModel: 'Toyota Camry',
      vehicleColor: 'Silver',
      servicePrice: 500,
      date: 'Jan 15, 2026',
      time: '10:00 AM',
      location: '123 Main St.',
    ),
    AdminBookingItem(
      bookingId: '#1235',
      vehicle: 'Compact SUV',
      service: 'Exterior & Interior',
      status: AdminBookingStatus.active,
      customerName: 'John Smith',
      customerPhone: '+971 50 123 4567',
      customerEmail: 'john@example.com',
      vehicleMakeModel: 'Range Rover',
      vehicleColor: 'Black',
      servicePrice: 650,
      date: 'Jan 23, 2026',
      time: '11:30 AM',
      location: 'Dubai',
    ),
    AdminBookingItem(
      bookingId: '#1236',
      vehicle: 'Full Size SUV',
      service: 'Exterior & Interior',
      status: AdminBookingStatus.inProgress,
      customerName: 'Sara Johnson',
      customerPhone: '+971 50 987 6543',
      customerEmail: 'sara@example.com',
      vehicleMakeModel: 'Chevrolet Tahoe',
      vehicleColor: 'White',
      servicePrice: 750,
      date: 'Jan 20, 2026',
      time: '02:00 PM',
      location: 'JBR',
    ),
    AdminBookingItem(
      bookingId: '#1237',
      vehicle: 'Minivan',
      service: 'Exterior Only',
      status: AdminBookingStatus.inReview,
      customerName: 'Walter White',
      customerPhone: '+971 50 555 1234',
      customerEmail: 'walter@example.com',
      vehicleMakeModel: 'Honda Odyssey',
      vehicleColor: 'Gray',
      servicePrice: 300,
      date: 'Jan 18, 2026',
      time: '09:00 AM',
      location: 'Downtown Dubai',
    ),
    AdminBookingItem(
      bookingId: '#1238',
      vehicle: 'Sedan',
      service: 'Exterior Only',
      status: AdminBookingStatus.completed,
      customerName: 'Michael Brown',
      customerPhone: '+971 50 111 2222',
      customerEmail: 'michael@example.com',
      vehicleMakeModel: 'BMW 3 Series',
      vehicleColor: 'Blue',
      servicePrice: 400,
      date: 'Jan 10, 2026',
      time: '03:00 PM',
      location: 'Marina',
    ),
    AdminBookingItem(
      bookingId: '#1239',
      vehicle: 'Truck',
      service: 'Full Detailing',
      status: AdminBookingStatus.cancelled,
      customerName: 'Emma Davis',
      customerPhone: '+971 50 333 4444',
      customerEmail: 'emma@example.com',
      vehicleMakeModel: 'Ford F-150',
      vehicleColor: 'Red',
      servicePrice: 900,
      date: 'Jan 12, 2026',
      time: '01:00 PM',
      location: 'Business Bay',
    ),
    AdminBookingItem(
      bookingId: '#1240',
      vehicle: 'Compact SUV',
      service: 'Interior Cleaning',
      status: AdminBookingStatus.unassigned,
      customerName: 'David Wilson',
      customerPhone: '+971 50 555 6666',
      customerEmail: 'david@example.com',
      vehicleMakeModel: 'Honda CR-V',
      vehicleColor: 'Green',
      servicePrice: 350,
      date: 'Jan 25, 2026',
      time: '04:00 PM',
      location: 'Downtown',
    ),
    AdminBookingItem(
      bookingId: '#1241',
      vehicle: 'Sedan',
      service: 'Exterior & Interior',
      status: AdminBookingStatus.pending,
      customerName: 'Lisa Anderson',
      customerPhone: '+971 50 777 8888',
      customerEmail: 'lisa@example.com',
      vehicleMakeModel: 'Mercedes C-Class',
      vehicleColor: 'Silver',
      servicePrice: 800,
      date: 'Jan 28, 2026',
      time: '11:00 AM',
      location: 'JBR',
    ),
    AdminBookingItem(
      bookingId: '#1242',
      vehicle: 'Full Size SUV',
      service: 'Exterior Only',
      status: AdminBookingStatus.active,
      customerName: 'James Taylor',
      customerPhone: '+971 50 999 0000',
      customerEmail: 'james@example.com',
      vehicleMakeModel: 'Cadillac Escalade',
      vehicleColor: 'Black',
      servicePrice: 600,
      date: 'Jan 22, 2026',
      time: '09:30 AM',
      location: 'Palm Jumeirah',
    ),
    AdminBookingItem(
      bookingId: '#1243',
      vehicle: 'Minivan',
      service: 'Exterior & Interior',
      status: AdminBookingStatus.inProgress,
      customerName: 'Rachel Green',
      customerPhone: '+971 50 111 3333',
      customerEmail: 'rachel@example.com',
      vehicleMakeModel: 'Toyota Sienna',
      vehicleColor: 'White',
      servicePrice: 700,
      date: 'Jan 19, 2026',
      time: '02:30 PM',
      location: 'Al Baraha',
    ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Filter bookings based on filterType
    final filteredBookings = widget.filterType == null
        ? bookings
        : bookings.where((booking) {
            if (widget.filterType == 'active') {
              return booking.status == AdminBookingStatus.active;
            } else if (widget.filterType == 'completed') {
              return booking.status == AdminBookingStatus.completed;
            }
            return true;
          }).toList();

    return SafeArea(
      child: Column(
        children: [
          // Header with centered text and optional back button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                // Back button on left (only if showBackButton is true)
                if (widget.showBackButton)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                    ),
                  )
                else
                  const SizedBox(width: 28),
                // Centered text
                Expanded(
                  child: Center(
                    child: Text(
                      widget.filterType == 'active'
                          ? 'Active Orders'
                          : widget.filterType == 'completed'
                              ? 'Completed Orders'
                              : 'Bookings',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.dark,
                        height: 1.29,
                      ),
                    ),
                  ),
                ),
                // Spacer to balance the layout
                const SizedBox(width: 28),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Content
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 100),
              itemCount: filteredBookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => _BookingCard(booking: filteredBookings[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final AdminBookingItem booking;

  const _BookingCard({required this.booking});

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
          // Booking ID and status on same line
          Row(
            children: [
              Text(
                booking.bookingId,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(width: 12),
              _StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: 12),
          // Vehicle
          Text(
            'Vehicle: ${booking.vehicle}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 4),
          // Service
          Text(
            'Service: ${booking.service}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 12),
          // Review button (for pending) and View Details button
          Row(
            children: [
              if (booking.status == AdminBookingStatus.pending)
                GestureDetector(
                  onTap: () {
                    // Create a BookingItem from AdminBookingItem data
                    final bookingItem = BookingItem(
                      bookingId: booking.bookingId,
                      service: booking.service,
                      amount: booking.servicePrice,
                      status: BookingStatus.completed,
                      dateTime: '${booking.date} at ${booking.time}',
                      location: booking.location,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookingDetailsScreen(
                          booking: bookingItem,
                          isAdminReview: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9966),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // View Details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AdminBookingDetailsScreen(
                    bookingId: booking.bookingId,
                    status: booking.status == AdminBookingStatus.pending
                        ? 'Pending'
                        : booking.status == AdminBookingStatus.completed
                            ? 'Completed'
                            : 'Cancelled',
                    customerName: booking.customerName,
                    customerPhone: booking.customerPhone,
                    customerEmail: booking.customerEmail,
                    vehicleType: booking.vehicle,
                    vehicleMakeModel: booking.vehicleMakeModel,
                    vehicleColor: booking.vehicleColor,
                    serviceType: booking.service,
                    servicePrice: booking.servicePrice,
                    date: booking.date,
                    time: booking.time,
                    location: booking.location,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F2F2),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AdminBookingStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      AdminBookingStatus.pending => ('Pending', const Color(0xFFFEF3C7), const Color(0xFFF59E0B)),
      AdminBookingStatus.active => ('Active', const Color(0xFFDEF7EC), const Color(0xFF047857)),
      AdminBookingStatus.inProgress => ('In Progress', const Color(0xFFE0E7FF), const Color(0xFF4F46E5)),
      AdminBookingStatus.inReview => ('In Review', const Color(0xFFFCE7F3), const Color(0xFFBE185D)),
      AdminBookingStatus.completed => ('Completed', const Color(0xFFD4F5E0), const Color(0xFF10B981)),
      AdminBookingStatus.cancelled => ('Cancelled', const Color(0xFFFEE2E2), const Color(0xFFEF4444)),
      AdminBookingStatus.unassigned => ('Unassigned', const Color(0xFFF3F4F6), const Color(0xFF6B7280)),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: fg,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ],
    );
  }
}
