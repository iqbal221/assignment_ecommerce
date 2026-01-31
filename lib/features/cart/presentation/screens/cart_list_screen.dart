import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/app/app_constant.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/widgets/cart_item.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartListProvider>().fetchCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        context.read<MainNavContainerProvider>().backToHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text("Cart")),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Consumer<CartListProvider>(
                  builder: (context, cartListProvider, child) {
                    if (cartListProvider.cartListInProgress) {
                      return CenterCircularProgress();
                    }
                    return ListView.builder(
                      itemCount: cartListProvider.cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartListModel: cartListProvider.cartList[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            _buildTotalPriceAndCheckoutSection(),
          ],
        ),
      ),
    );
  }

  Container _buildTotalPriceAndCheckoutSection() {
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
              Text("Total Price", style: TextTheme.of(context).bodyLarge),
              Consumer<CartListProvider>(
                builder: (context, cartListProvider, child) {
                  return Text(
                    "${AppConstant.takaSign}${cartListProvider.totalPrice}",
                    style: TextTheme.of(context).titleLarge?.copyWith(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(
              onPressed: () {},
              child: Text(
                "Checkout",
                style: TextTheme.of(
                  context,
                ).bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
