import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/image_path.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.height = 100,
    this.width = 80,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImagePath.logoSvg,
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}
