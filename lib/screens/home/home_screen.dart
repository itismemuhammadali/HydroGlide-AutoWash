import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_colors.dart';
import '../../widgets/search_bar.dart';
import '../booking/confirm_booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const HomeBody();
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _selectedVehicle = 0;
  int _selectedPackage = 0;

  void _navigateToBooking() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ConfirmBookingScreen(
        vehicleType: _vehicles[_selectedVehicle].label,
        service: _selectedPackage == 0 ? 'Exterior Only' : 'Exterior & Interior',
      ),
    ));
  }

  final List<_VehicleType> _vehicles = [
    _VehicleType(label: 'Sedan', imagePath: 'assets/images/car_tesla.webp'),
    _VehicleType(label: 'Compact SUV', imagePath: 'assets/images/car_compact_suv.webp'),
    _VehicleType(label: 'Full SUV', imagePath: 'assets/images/car_full_suv.webp'),
    _VehicleType(label: 'Minivan', imagePath: 'assets/images/car_minivan.webp'),
    _VehicleType(label: 'Pickup Truck', imagePath: 'assets/images/car_truck.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, size: 18, color: AppColors.dark),
                        SizedBox(width: 4),
                        Text(
                          'Abu Dhabi',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.white),
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
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select Vehicle & Package',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    const SizedBox(height: 14),
                    // Vehicle selector + package card
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Vehicle list
                          Column(
                            children: List.generate(_vehicles.length, (i) {
                              final isSelected = i == _selectedVehicle;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedVehicle = i),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.dark : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.10),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/headlight.svg',
                                        width: 26,
                                        height: 26,
                                        colorFilter: ColorFilter.mode(
                                          isSelected ? Colors.white : AppColors.dark,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      if (isSelected) ...[
                                        const SizedBox(height: 3),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(
                                            _vehicles[i].label,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 12),
                          // Package card — stretches to match list height
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.10),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                      child: Image.asset(
                                        _vehicles[_selectedVehicle].imagePath,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        _PackageOption(
                                          label: 'Exterior Only',
                                          price: '185 AED',
                                          selected: _selectedPackage == 0,
                                          onTap: () => setState(() => _selectedPackage = 0),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _PackageOption(
                                                label: 'Exterior & Interior',
                                                price: '500 AED',
                                                selected: _selectedPackage == 1,
                                                onTap: () => setState(() => _selectedPackage = 1),
                                              ),
                                            ),
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: AppColors.dark,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withValues(alpha: 0.2),
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: GestureDetector(
                                                onTap: _navigateToBooking,
                                                child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // My Bookings
                    const Text('My Bookings',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 36),
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
                      child: const Column(
                        children: [
                          Icon(Icons.science_outlined, size: 48, color: AppColors.dark),
                          SizedBox(height: 12),
                          Text('No Active Bookings',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.dark)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Packages
                    const Text('Packages',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.dark)),
                    const SizedBox(height: 12),
                    _PackageCard(
                      title: 'Exterior Only',
                      selected: _selectedPackage == 0,
                      features: const [
                        'Bug and Tar Removal',
                        'Exterior Steam Detailing',
                        'Steam Clean Rim Faces & Tires',
                        'Clean Wheel Wells',
                        'Dress and Shine Tires',
                        'Steam Clean Door Jam',
                        'Windows In & Out',
                      ],
                      onSelect: () => setState(() => _selectedPackage = 0),
                      onBook: _navigateToBooking,
                    ),
                    const SizedBox(height: 12),
                    _PackageCard(
                      title: 'Exterior & Interior',
                      selected: _selectedPackage == 1,
                      features: const [
                        'Everything in Exterior Only',
                        'Interior Steam Cleaning',
                        'Seat & Carpet Cleaning',
                        'Dashboard & Console Wipe',
                        'Door Panels Cleaned',
                        'Interior Windows Cleaned',
                      ],
                      onSelect: () => setState(() => _selectedPackage = 1),
                      onBook: _navigateToBooking,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class _VehicleType {
  final String label;
  final String imagePath;
  const _VehicleType({required this.label, required this.imagePath});
}

class _PackageOption extends StatelessWidget {
  final String label;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  const _PackageOption({
    required this.label,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            size: 18,
            color: AppColors.dark,
          ),
          const SizedBox(width: 8),
          Text(
            '$label - ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              color: AppColors.dark,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String title;
  final bool selected;
  final List<String> features;
  final VoidCallback onSelect;
  final VoidCallback onBook;

  const _PackageCard({
    required this.title,
    required this.selected,
    required this.features,
    required this.onSelect,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Title row
          Row(
            children: [
              GestureDetector(
                onTap: onSelect,
                child: Icon(
                  selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  size: 20,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
          // Expanded details when selected
          if (selected) ...[
            const SizedBox(height: 12),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: AppColors.dark, fontSize: 13)),
                      Expanded(child: Text(f, style: const TextStyle(color: AppColors.dark, fontSize: 13))),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: _BookButton(onTap: onBook),
            ),
          ] else ...[
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onSelect,
                  child: const Text(
                    'View Details',
                    style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                _BookButton(onTap: onBook),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _BookButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BookButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Text(
          'Book a Wash',
          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
