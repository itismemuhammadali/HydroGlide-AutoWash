import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isNew;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isNew = false,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => const NotificationsBody();
}

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  static const _notifications = [
    NotificationItem(title: 'Booking Completed', message: 'Your steam detailing booking has been completed\nby Ahmed Al-Mansoori', time: '2m ago', isNew: true),
    NotificationItem(title: 'Booking Assigned', message: 'Your steam detailing booking has been assigned\nto Ahmed Al-Mansoori', time: '52m ago', isNew: true),
    NotificationItem(title: 'Booking Confirmed', message: 'Congratulations on your first booking.', time: '2 days ago'),
    NotificationItem(title: 'Booking Canceled', message: 'Your booking is canceled successfully', time: '12 days ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text('Notifications',
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _notifications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _NotificationCard(item: _notifications[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
              if (item.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF5B5FEF), borderRadius: BorderRadius.circular(20)),
                  child: const Text('New', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.message, style: const TextStyle(fontSize: 13, color: AppColors.grey, height: 1.4)),
          const SizedBox(height: 10),
          Text(item.time, style: const TextStyle(fontSize: 12, color: AppColors.grey)),
        ],
      ),
    );
  }
}
