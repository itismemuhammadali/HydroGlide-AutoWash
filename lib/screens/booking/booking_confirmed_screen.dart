import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../screens/shell/app_shell.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 12),
              child: IconButton(
                icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Icon(Icons.done_all_rounded, size: 52, color: AppColors.dark),
                    const SizedBox(height: 16),
                    const Text(
                      'Booking Confirmed',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.dark),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your steam detailing has been scheduled',
                      style: TextStyle(fontSize: 15, color: AppColors.grey),
                    ),
                    const SizedBox(height: 32),
                    // What Happens Next card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('What Happens Next',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          const SizedBox(height: 20),
                          _TimelineItem(
                            label: 'Booking Confirmed',
                            sublabel: 'Just now',
                            isCompleted: true,
                            isLast: false,
                          ),
                          _TimelineItem(
                            label: 'Driver assigned',
                            sublabel: 'In ~ 5 minutes',
                            isCompleted: false,
                            isLast: false,
                          ),
                          _TimelineItem(
                            label: 'Service',
                            sublabel: 'In ~ 35 minutes',
                            isCompleted: false,
                            isLast: false,
                          ),
                          _TimelineItem(
                            label: 'Service Completed',
                            sublabel: '',
                            isCompleted: false,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Back to Home',
                        verticalPadding: 22,
                        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const AppShell()),
                          (route) => false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String label;
  final String sublabel;
  final bool isCompleted;
  final bool isLast;

  const _TimelineItem({
    required this.label,
    required this.sublabel,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon + line
        Column(
          children: [
            isCompleted
                ? const Icon(Icons.check_circle, color: Colors.green, size: 24)
                : const Icon(Icons.access_time, color: AppColors.dark, size: 24),
            if (!isLast)
              Container(width: 2, height: 32, color: const Color(0xFFDDDDDD)),
          ],
        ),
        const SizedBox(width: 14),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark)),
              if (sublabel.isNotEmpty)
                Text(sublabel, style: const TextStyle(fontSize: 11, color: AppColors.grey)),
              if (!isLast) const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
