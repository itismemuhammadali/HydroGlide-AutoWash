import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import '../auth/login_screen.dart';
import '../../widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Wash N Roll',
      subtitle: 'Seamless Mobile Steam Detailing\nmobile app',
      imagePath: 'assets/images/car_full_suv.webp',
    ),
    OnboardingData(
      title: 'Doorstep Steam Detailing\n& Detailing',
      subtitle: 'Choose from a variety of services including steam cleaning,\nsteam detailing, and full detailing',
      imagePath: 'assets/images/car_compact_suv.webp',
    ),
    OnboardingData(
      title: 'Convenient Car Steam\nWash Service',
      subtitle: 'Get your car cleaned professionally at your\ndoorstep with our premium services',
      imagePath: '',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _goToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow (hidden on first page)
                  _currentPage > 0
                      ? GestureDetector(
                          onTap: _prevPage,
                          child: const Icon(Icons.chevron_left, size: 28, color: Color(0xFF1A1A2E)),
                        )
                      : const SizedBox(width: 28),
                  // Logo top-right (hidden on first page)
                  _currentPage > 0
                      ? Image.asset(
                          'assets/images/logo_3.webp',
                          height: 64,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(width: 60),
                        )
                      : const SizedBox(width: 60),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _OnboardingPage(data: _pages[index], index: index),
              ),
            ),
            _DotsIndicator(count: _pages.length, current: _currentPage),
            const SizedBox(height: 24),
            _BottomButtons(
              onSkip: _goToHome,
              onNext: _nextPage,
              isLast: _currentPage == _pages.length - 1,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int index;

  const _OnboardingPage({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return _FirstPage(data: data);
    }
    return _InnerPage(data: data);
  }
}

// Page 1 layout: centered logo + title + subtitle + car
class _FirstPage extends StatelessWidget {
  final OnboardingData data;
  const _FirstPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Image.asset(
            'assets/images/logo_3.webp',
            height: 180,
            errorBuilder: (context, error, stackTrace) => const _LogoPlaceholder(),
          ),
          Transform.translate(
            offset: const Offset(0, -16),
            child: Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B6B6B),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Image.asset(
              data.imagePath,
              height: 220,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const _CarPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}

// Page 2+ layout: title + subtitle top, car image centered below
class _InnerPage extends StatelessWidget {
  final OnboardingData data;
  const _InnerPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A1A2E),
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF6B6B6B),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: data.imagePath.isEmpty
              ? const _VideoThumbnail()
              : Image.asset(
                  data.imagePath,
                  height: 220,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const _CarPlaceholder(),
                ),
        ),
      ],
    );
  }
}

class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text('LOGO', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _CarPlaceholder extends StatelessWidget {
  const _CarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(Icons.directions_car, size: 80, color: Colors.grey),
      ),
    );
  }
}

class _VideoThumbnail extends StatefulWidget {
  const _VideoThumbnail();

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/onboarding_video1.mp4')
      ..initialize().then((_) {
        setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_initialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              else
                const Center(child: CircularProgressIndicator(color: Colors.white)),
              // Play/pause overlay
              if (_initialized && !_controller.value.isPlaying)
                SvgPicture.asset(
                  'assets/images/play.svg',
                  width: 56,
                  height: 56,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int current;

  const _DotsIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1A1A2E) : const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final bool isLast;

  const _BottomButtons({
    required this.onSkip,
    required this.onNext,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    if (isLast) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: AppButton(label: 'Book now!', onPressed: onNext),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: AppButton(label: 'Skip', onPressed: onSkip)),
          const SizedBox(width: 16),
          Expanded(child: AppButton(label: 'Next', onPressed: onNext)),
        ],
      ),
    );
  }
}
