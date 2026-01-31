import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/category/data/models/category_model.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/screens/product_list_by_category_screen.dart';

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListByCategoryScreen.name,
          arguments: categoryModel,
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColors.themeColor.withAlpha(30),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(
                categoryModel.icon,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, weight: 28, color: Colors.grey),
              ),
            ),
          ),

          Text(
            categoryModel.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.themeColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
