import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'upload_proof_screen.dart';

enum TaskStatus { newAssignment, active, completed }

class TaskDetailsScreen extends StatefulWidget {
  final TaskStatus status;
  final String taskId;
  final String customerName;
  final String customerPhone;
  final String vehicleType;
  final String vehicleMakeModel;
  final String vehicleColor;
  final String serviceType;
  final double servicePrice;
  final String date;
  final String time;
  final String location;

  const TaskDetailsScreen({
    super.key,
    required this.status,
    required this.taskId,
    required this.customerName,
    required this.customerPhone,
    required this.vehicleType,
    required this.vehicleMakeModel,
    required this.vehicleColor,
    required this.serviceType,
    required this.servicePrice,
    required this.date,
    required this.time,
    required this.location,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status;
  }

  String get _statusText {
    switch (_currentStatus) {
      case TaskStatus.newAssignment:
        return 'New Assignment';
      case TaskStatus.active:
        return 'Active';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get _statusColor {
    switch (_currentStatus) {
      case TaskStatus.newAssignment:
        return const Color(0xFF2563EB);
      case TaskStatus.active:
        return const Color(0xFFF59E0B);
      case TaskStatus.completed:
        return const Color(0xFF10B981);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                        'Task details',
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
                  children: [
                    // Status badge
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _statusColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _statusText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Customer Information
                    _InfoCard(
                      icon: Icons.person_outline,
                      iconColor: const Color(0xFF3B82F6),
                      title: 'Customer Information',
                      items: [
                        ('Name', widget.customerName),
                        ('Phone', widget.customerPhone),
                      ],
                      bgColor: const Color(0xFFDEEBF7),
                    ),
                    const SizedBox(height: 12),
                    // Vehicle Details
                    _InfoCard(
                      svgPath: 'assets/images/car_right_side.svg',
                      iconColor: const Color(0xFF10B981),
                      title: 'Vehicle Details',
                      items: [
                        ('Type', widget.vehicleType),
                        ('Make / Model', widget.vehicleMakeModel),
                        ('Color', widget.vehicleColor),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Service Selected
                    _InfoCard(
                      icon: Icons.settings_outlined,
                      iconColor: const Color(0xFFA855F7),
                      title: 'Service Selected',
                      items: [
                        ('Service Type', widget.serviceType),
                        ('Price', '${widget.servicePrice.toStringAsFixed(0)} AED'),
                      ],
                      bgColor: const Color(0xFFE9D5FF),
                    ),
                    const SizedBox(height: 12),
                    // Date & Time
                    _InfoCard(
                      icon: Icons.calendar_today_outlined,
                      iconColor: const Color(0xFF22C55E),
                      title: 'Date & Time',
                      items: [
                        ('Date', widget.date),
                        ('Time', widget.time),
                        ('Location', widget.location),
                      ],
                      bgColor: const Color(0xFFDCFCE7),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Action button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    switch (_currentStatus) {
      case TaskStatus.newAssignment:
        return SizedBox(
          width: double.infinity,
          child: AppButton(
            label: 'Accept Task',
            onPressed: () {
              setState(() {
                _currentStatus = TaskStatus.active;
              });
            },
            backgroundColor: AppColors.dark,
            textColor: Colors.white,
          ),
        );
      case TaskStatus.active:
        return SizedBox(
          width: double.infinity,
          child: AppButton(
            label: 'Mark as Completed',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => UploadProofScreen(
                    taskId: widget.taskId,
                    serviceType: widget.serviceType,
                    timeTaken: 42,
                  ),
                ),
              );
            },
            backgroundColor: AppColors.dark,
            textColor: Colors.white,
          ),
        );
      case TaskStatus.completed:
        return const SizedBox.shrink();
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final Color iconColor;
  final String title;
  final List<(String label, String value)> items;
  final Color? bgColor;

  const _InfoCard({
    this.icon,
    this.svgPath,
    required this.iconColor,
    required this.title,
    required this.items,
    this.bgColor,
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
          // Title with icon
          Row(
            children: [
              if (svgPath != null)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA8F5E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svgPath!,
                      width: 15,
                      height: 15,
                      colorFilter: const ColorFilter.mode(Color(0xFF00B777), BlendMode.srcIn),
                    ),
                  ),
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: bgColor ?? iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Items
          ...items.asMap().entries.map((entry) {
            final isLast = entry.key == items.length - 1;
            final (label, value) = entry.value;
            return Column(
              children: [
                Row(
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
                if (!isLast) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 12),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
