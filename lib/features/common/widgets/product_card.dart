import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/app/app_constant.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/favourite_button.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/rating_view.dart';
import 'package:ecommerce_assignment_module_31/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   // ProductDetailsScreen.name,
        //   arguments: productModel.id,
        // );
      },
      child: SizedBox(
        width: 160,
        child: Card(
          shadowColor: AppColors.themeColor.withAlpha(80),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: AppColors.themeColor.withAlpha(30),
                  image: productModel.photo != null
                      ? DecorationImage(
                          image: NetworkImage(productModel.photo!),
                        )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      productModel.title,
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppConstant.takaSign}${productModel.currentPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeColor,
                          ),
                        ),
                        RatingView(),
                        FavouriteButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
