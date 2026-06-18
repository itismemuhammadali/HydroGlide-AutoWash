import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import '../shell/app_shell.dart';

enum ApprovalStatus { waiting, approved, rejected }

class TaskApprovalStatusScreen extends StatelessWidget {
  final String taskId;
  final ApprovalStatus status;
  final String? adminNote;

  const TaskApprovalStatusScreen({
    super.key,
    required this.taskId,
    this.status = ApprovalStatus.waiting,
    this.adminNote,
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
                      // Status icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: _getStatusBackgroundColor(),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: Icon(
                            _getStatusIcon(),
                            size: 60,
                            color: _getStatusIconColor(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Status title
                      Text(
                        _getStatusTitle(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Status message
                      Text(
                        _getStatusMessage(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Task ID
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
                              'Task ID: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF999999),
                              ),
                            ),
                            Text(
                              taskId,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Admin note (if rejected)
                      if (status == ApprovalStatus.rejected && adminNote != null)
                        Column(
                          children: [
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE2E2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFEF4444),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Admin Note:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFEF4444),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    adminNote!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                      builder: (_) => const AppShell(role: 'Employee'),
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

  String _getStatusTitle() {
    switch (status) {
      case ApprovalStatus.waiting:
        return 'Waiting for Approval';
      case ApprovalStatus.approved:
        return 'Task Approved';
      case ApprovalStatus.rejected:
        return 'Task Rejected';
    }
  }

  String _getStatusMessage() {
    switch (status) {
      case ApprovalStatus.waiting:
        return 'Your task submission is under review.\nPlease wait for the admin to approve or reject it.';
      case ApprovalStatus.approved:
        return 'Congratulations! Your task has been\napproved by the administrator.';
      case ApprovalStatus.rejected:
        return 'Your task submission has been rejected.\nPlease review the admin note and resubmit.';
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case ApprovalStatus.waiting:
        return Icons.schedule;
      case ApprovalStatus.approved:
        return Icons.check_circle;
      case ApprovalStatus.rejected:
        return Icons.cancel;
    }
  }

  Color _getStatusIconColor() {
    switch (status) {
      case ApprovalStatus.waiting:
        return const Color(0xFF3B82F6);
      case ApprovalStatus.approved:
        return const Color(0xFF10B981);
      case ApprovalStatus.rejected:
        return const Color(0xFFEF4444);
    }
  }

  Color _getStatusBackgroundColor() {
    switch (status) {
      case ApprovalStatus.waiting:
        return const Color(0xFFDBEAFE);
      case ApprovalStatus.approved:
        return const Color(0xFFD4F5E0);
      case ApprovalStatus.rejected:
        return const Color(0xFFFEE2E2);
    }
  }
}
