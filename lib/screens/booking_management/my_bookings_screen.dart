import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'booking_details_screen.dart';

enum BookingStatus { pending, active, inProgress, inReview, completed, cancelled, unassigned }

class BookingItem {
  final String service;
  final String bookingId;
  final String dateTime;
  final String location;
  final double amount;
  final BookingStatus status;

  const BookingItem({
    required this.service,
    required this.bookingId,
    required this.dateTime,
    required this.location,
    required this.amount,
    required this.status,
  });
}

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) => const MyBookingsBody();
}

class MyBookingsBody extends StatefulWidget {
  const MyBookingsBody({super.key});

  @override
  State<MyBookingsBody> createState() => _MyBookingsBodyState();
}

class _MyBookingsBodyState extends State<MyBookingsBody> {

  final List<BookingItem> _bookings = const [
    BookingItem(
      service: 'Exterior & Interior',
      bookingId: '#1243',
      dateTime: 'Today at 2:30 Pm',
      location: '123 Main St.',
      amount: 500,
      status: BookingStatus.inProgress,
    ),
    BookingItem(
      service: 'Exterior & Interior',
      bookingId: '#1345',
      dateTime: 'Jan 15, 2026 at 12:30 Pm',
      location: '123 Main St.',
      amount: 500,
      status: BookingStatus.completed,
    ),
    BookingItem(
      service: 'Exterior Only',
      bookingId: '#1421',
      dateTime: 'Jan 8, 2026 at 11:30 Am',
      location: '123 Main St.',
      amount: 165,
      status: BookingStatus.completed,
    ),
    BookingItem(
      service: 'Exterior Only',
      bookingId: '#1422',
      dateTime: 'Jan 1, 2026 at 10:00 Am',
      location: '123 Main St.',
      amount: 165,
      status: BookingStatus.cancelled,
    ),
    BookingItem(
      service: 'Full Detailing',
      bookingId: '#1423',
      dateTime: 'Jan 25, 2026 at 03:00 Pm',
      location: 'Dubai Marina',
      amount: 800,
      status: BookingStatus.pending,
    ),
    BookingItem(
      service: 'Interior Cleaning',
      bookingId: '#1424',
      dateTime: 'Jan 28, 2026 at 09:00 Am',
      location: 'JBR',
      amount: 350,
      status: BookingStatus.active,
    ),
    BookingItem(
      service: 'Exterior & Interior',
      bookingId: '#1425',
      dateTime: 'Jan 30, 2026 at 01:00 Pm',
      location: 'Downtown Dubai',
      amount: 600,
      status: BookingStatus.inReview,
    ),
    BookingItem(
      service: 'Exterior Only',
      bookingId: '#1426',
      dateTime: 'Feb 2, 2026 at 11:00 Am',
      location: 'Business Bay',
      amount: 400,
      status: BookingStatus.unassigned,
    ),
    BookingItem(
      service: 'Full Detailing',
      bookingId: '#1427',
      dateTime: 'Feb 5, 2026 at 04:30 Pm',
      location: 'Palm Jumeirah',
      amount: 950,
      status: BookingStatus.completed,
    ),
    BookingItem(
      service: 'Exterior & Interior',
      bookingId: '#1428',
      dateTime: 'Feb 8, 2026 at 02:00 Pm',
      location: 'Al Baraha',
      amount: 700,
      status: BookingStatus.inProgress,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
            child: const Text('My Bookings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                  height: 1.29,
                )),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 100),
              itemCount: _bookings.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => BookingDetailsScreen(booking: _bookings[i])),
                ),
                child: _BookingCard(booking: _bookings[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingItem booking;
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
          // Service title and status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  booking.service,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
              ),
              _StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: 4),
          // Booking ID
          Text(
            booking.bookingId,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF999999),
            ),
          ),
          const SizedBox(height: 12),
          // Date
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF999999)),
              const SizedBox(width: 6),
              Text(
                booking.dateTime,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Location
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF999999)),
              const SizedBox(width: 6),
              Text(
                booking.location,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Amount and cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${booking.amount.toStringAsFixed(0)} AED',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
              if (booking.status == BookingStatus.inProgress)
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Cancel Booking',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final BookingStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      BookingStatus.pending => ('Pending', const Color(0xFFFEF3C7), const Color(0xFFF59E0B)),
      BookingStatus.active => ('Active', const Color(0xFFDEF7EC), const Color(0xFF047857)),
      BookingStatus.inProgress => ('In Progress', const Color(0xFFDBEAFE), const Color(0xFF3B82F6)),
      BookingStatus.inReview => ('In Review', const Color(0xFFFCE7F3), const Color(0xFFBE185D)),
      BookingStatus.completed => ('Completed', const Color(0xFFD4F5E0), const Color(0xFF10B981)),
      BookingStatus.cancelled => ('Cancelled', const Color(0xFFFEE2E2), const Color(0xFFEF4444)),
      BookingStatus.unassigned => ('Unassigned', const Color(0xFFF3F4F6), const Color(0xFF6B7280)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
