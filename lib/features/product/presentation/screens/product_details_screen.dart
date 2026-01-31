import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/app/app_constant.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/widgets/inr_dcr_button.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/favourite_button.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/rating_view.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/snack_bar_message.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_details_provider.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/widgets/color_picker.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/widgets/product_image_slider.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = "/product-details";

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();
  final CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productDetailsProvider.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _productDetailsProvider),
          ChangeNotifierProvider(create: (_) => _cartListProvider),
        ],
        child: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.getProductDetailsInProgress) {
              return CenterCircularProgress();
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageSlider(
                          imageUrls:
                              _productDetailsProvider
                                  .productDetailsModel
                                  ?.photos ??
                              [],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _productDetailsProvider
                                              .productDetailsModel
                                              ?.title ??
                                          "",
                                      style: textTheme.titleMedium,
                                    ),
                                  ),
                                  InrDcrButton(
                                    onChange: (int p1) {},
                                    maxValue:
                                        _productDetailsProvider
                                            .productDetailsModel
                                            ?.quantity ??
                                        20,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingView(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Reviews"),
                                  ),
                                  FavouriteButton(),
                                ],
                              ),
                              if (_productDetailsProvider
                                      .productDetailsModel
                                      ?.colors
                                      .isNotEmpty ??
                                  false)
                                Text("Colors", style: textTheme.titleMedium),
                              SizedBox(height: 12),
                              ColorPicker(
                                colors:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.colors ??
                                    [],
                                onChange: (selectedColor) {},
                              ),
                              SizedBox(height: 16),
                              if (_productDetailsProvider
                                      .productDetailsModel
                                      ?.sizes
                                      .isNotEmpty ??
                                  false)
                                Text("Sizes", style: textTheme.titleMedium),
                              SizedBox(height: 12),
                              SizePicker(
                                sizes:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.sizes ??
                                    [],
                                onChange: (selectedSize) {},
                              ),
                              SizedBox(height: 16),
                              Text("Description", style: textTheme.titleMedium),
                              SizedBox(height: 8),
                              Text(
                                _productDetailsProvider
                                        .productDetailsModel
                                        ?.description ??
                                    "",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildTotalPriceAndAddToCartSection(textTheme),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTotalPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Price", style: textTheme.bodyLarge),
              Text(
                "${AppConstant.takaSign}${_productDetailsProvider.productDetailsModel?.price ?? ''}",
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: Consumer<CartListProvider>(
              builder: (context, cartListProvider, child) {
                if (cartListProvider.cartListInProgress) {
                  return CenterCircularProgress();
                }
                return FilledButton(
                  onPressed: _onTapAddToCartButton,
                  child: Text(
                    "Add To Cart",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTapAddToCartButton() async {
    if (await AuthController.isUserLoggedIn()) {
      final bool isSuccess = await _cartListProvider.addToCart(
        widget.productId,
      );
      if (isSuccess) {
        ShowSnackBarMessage(context, "Added to cart");
      } else {
        ShowSnackBarMessage(context, _cartListProvider.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
}
