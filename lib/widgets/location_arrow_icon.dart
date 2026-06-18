import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationArrowIcon extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const LocationArrowIcon({
    super.key,
    this.width = 20,
    this.height = 20,
    this.color = const Color(0xFF555555),
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '<svg width="13" height="13" viewBox="0 0 13 13" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1.55746 4.82882L9.81663 0.896152C11.0208 0.322402 12.2774 1.57969 11.7043 2.78457L7.77167 11.043C7.23404 12.1714 5.60488 12.102 5.16571 10.9311L4.43896 8.99099C4.36795 8.80171 4.25725 8.62983 4.11431 8.48689C3.97136 8.34394 3.79948 8.23325 3.61021 8.16223L1.66938 7.43478C0.499209 6.99561 0.429084 5.36644 1.55746 4.82882Z" stroke="#555555" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
      width: width,
      height: height,
    );
  }
}
