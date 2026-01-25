import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_assignment_module_31/features/category/presentation/providers/category_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/category/presentation/screens/category_list_screen.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/providers/home_slider_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = "/main-nav-holder";

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductListProvider>().fetchProductList();
    context.read<CategoryListProvider>().fetchCategoryList();
    context.read<HomeSliderProvider>().getHomeSliders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavContainerProvider>(
      builder: (context, mainNavContainerProvider, child) {
        return Scaffold(
          body: _screens[mainNavContainerProvider.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColors.themeColor,
            currentIndex: mainNavContainerProvider.selectedIndex,
            onTap: (int index) async {
              if (index == 2 || index == 3) {
                if (await AuthController.isUserLoggedIn() == false) {
                  Navigator.pushNamed(context, SignUpScreen.name);
                }
              }
              mainNavContainerProvider.changeItem(index);
            },
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Carts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_rounded),
                label: "Wishlists",
              ),
            ],
          ),
        );
      },
    );
  }
}
