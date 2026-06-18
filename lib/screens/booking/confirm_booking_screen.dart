import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'confirm_payment_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  final String vehicleType;
  final String service;

  const ConfirmBookingScreen({
    super.key,
    required this.vehicleType,
    required this.service,
  });

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final _ddController = TextEditingController();
  final _timeController = TextEditingController(text: '00:00');
  bool _isAm = true;

  void _goToPayment() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const ConfirmPaymentScreen(serviceAmount: 500),
    ));
  }

  @override
  void dispose() {
    _ddController.dispose();
    _timeController.dispose();
    super.dispose();
  }

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
                  const Text('Confirm Booking',
                      style: TextStyle(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Review card
                    Container(
                      width: double.infinity,
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
                          const Text('Review Booking Information',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          const SizedBox(height: 16),
                          _InfoRow(label: 'Vehicle', value: widget.vehicleType),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(label: 'Service', value: widget.service),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          const _InfoRow(label: 'Location', value: '123 Main St.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(label: 'Book now!', onPressed: _goToPayment, verticalPadding: 22),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text('OR',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    ),
                    const SizedBox(height: 20),
                    const Text('Schedule your booking',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    const SizedBox(height: 16),
                    const Text('Set date',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.dark)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            _ddController.text = '${picked.day}/${picked.month}/${picked.year}';
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: AppColors.dark, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _ddController.text.isEmpty ? 'Select date' : _ddController.text,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _ddController.text.isEmpty ? const Color(0xFFAAAAAA) : AppColors.dark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Set time',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.dark)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _DateField(controller: _timeController, hint: '00:00', width: 80),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 3)),
                            ],
                          ),
                          child: Row(
                            children: [
                              _AmPmButton(label: 'AM', selected: _isAm, onTap: () => setState(() => _isAm = true)),
                              _AmPmButton(label: 'PM', selected: !_isAm, onTap: () => setState(() => _isAm = false)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(label: 'Book for later!', onPressed: _goToPayment, verticalPadding: 22),
                    ),
                    const SizedBox(height: 32),
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.grey)),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.dark)),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double width;
  const _DateField({required this.controller, required this.hint, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class _AmPmButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _AmPmButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.dark : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
