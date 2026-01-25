import 'package:ecommerce_assignment_module_31/app/app_assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssetsPath.appLogo,
      height: height,
      width: width ?? 100,
    );
  }
}
