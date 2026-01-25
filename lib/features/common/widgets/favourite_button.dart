import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: AppColors.themeColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.favorite_outline, size: 16, color: Colors.white),
      ),
    );
  }
}
