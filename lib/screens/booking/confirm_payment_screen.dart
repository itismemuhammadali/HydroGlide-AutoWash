import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'booking_confirmed_screen.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final double serviceAmount;

  const ConfirmPaymentScreen({super.key, required this.serviceAmount});

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  int _paymentMethod = 1; // 0 = Cash, 1 = Card
  final _bankController = TextEditingController();
  final _ibanController = TextEditingController();

  double get _tax => widget.serviceAmount * 0.1;
  double get _total => widget.serviceAmount + _tax;

  @override
  void dispose() {
    _bankController.dispose();
    _ibanController.dispose();
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 28, color: AppColors.dark),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'Confirm Payment',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.dark),
                  ),
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
                    // Payment details card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
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
                          const Text('Payment details',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          const SizedBox(height: 16),
                          _InfoRow(label: 'Service', value: '${widget.serviceAmount.toStringAsFixed(0)} AED'),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(label: 'Tax', value: '${_tax.toStringAsFixed(0)} AED'),
                          const Divider(height: 20, color: Color(0xFFEEEEEE)),
                          _InfoRow(label: 'Total', value: '${_total.toStringAsFixed(0)} AED'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Select payment method',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    const SizedBox(height: 16),
                    // Cash option
                    GestureDetector(
                      onTap: () => setState(() => _paymentMethod = 0),
                      child: Row(
                        children: [
                          Icon(
                            _paymentMethod == 0 ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            size: 22,
                            color: AppColors.dark,
                          ),
                          const SizedBox(width: 12),
                          const Text('Cash',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.dark)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Card option
                    GestureDetector(
                      onTap: () => setState(() => _paymentMethod = 1),
                      child: Row(
                        children: [
                          Icon(
                            _paymentMethod == 1 ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            size: 22,
                            color: AppColors.dark,
                          ),
                          const SizedBox(width: 12),
                          const Text('Card',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.dark)),
                        ],
                      ),
                    ),
                    // Card fields
                    if (_paymentMethod == 1) ...[
                      const SizedBox(height: 12),
                      const Text('Enter card details',
                          style: TextStyle(fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 10),
                      _CardField(controller: _bankController, hint: 'Bank name'),
                      const SizedBox(height: 10),
                      _CardField(controller: _ibanController, hint: 'Account number / IBAN'),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Confirm Payment',
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const BookingConfirmedScreen()),
                        ),
                        verticalPadding: 22,
                      ),
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

class _CardField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _CardField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: AppColors.dark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
