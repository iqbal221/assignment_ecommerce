import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/app/app_constant.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_assignment_module_31/features/cart/data/modals/cart_list_model.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/widgets/inr_dcr_button.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartListModel});

  final CartListModel? cartListModel;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final CartListProvider _cartListProvider = CartListProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(60),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.cartListModel?.photos[0] ?? ""),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartListModel?.title ?? "",
                          maxLines: 1,
                          style: textTheme.bodyMedium?.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.cartListModel!.colors.join(", "),
                          style: textTheme.bodySmall?.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Consumer<CartListProvider>(
                      builder: (context, cartListProvider, child) {
                        if (cartListProvider.cartListInProgress) {
                          return CenterCircularProgress();
                        }
                        return IconButton(
                          onPressed: _onTapDeleteCartItem,
                          icon: Icon(Icons.delete, color: Colors.grey),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppConstant.takaSign}${widget.cartListModel?.currentPrice ?? 0}",
                      style: textTheme.bodyLarge?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InrDcrButton(onChange: (int value) {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDeleteCartItem() async {
    if (await AuthController.isUserLoggedIn()) {
      final bool isSuccess = await _cartListProvider.deleteCartItem(
        widget.cartListModel!.id,
      );
      if (isSuccess) {
        ShowSnackBarMessage(context, "Deleted from cart");
      } else {
        ShowSnackBarMessage(context, _cartListProvider.errorMessage!);
      }
    } else {
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
}
