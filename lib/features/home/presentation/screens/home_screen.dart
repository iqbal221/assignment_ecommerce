import 'package:ecommerce_assignment_module_31/app/app_assets_path.dart';
import 'package:ecommerce_assignment_module_31/features/category/presentation/providers/category_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/category_card.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/product_card.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/providers/home_slider_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/widgets/circular_icon_button.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/widgets/product_search_field.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/widgets/section_header.dart';

import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildApppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 16,
            children: [
              ProductSearchField(),
              Consumer<HomeSliderProvider>(
                builder: (context, homeSlicerProvider, _) {
                  if (homeSlicerProvider.getHomeSliderInProgress) {
                    return SizedBox(
                      height: 200,
                      child: CenterCircularProgress(),
                    );
                  }
                  return HomeCarouselSlider(
                    sliders: homeSlicerProvider.homeSliders,
                  );
                },
              ),
              SectionHeader(
                title: "Categories",
                onTapSelectAll: () {
                  context.read<MainNavContainerProvider>().changeToCategories();
                },
              ),
              _buildCategoryList(),
              SectionHeader(title: "Popular", onTapSelectAll: () {}),
              _buildProductList(),
              SectionHeader(title: "Special", onTapSelectAll: () {}),
              SectionHeader(title: "New", onTapSelectAll: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return SizedBox(
      height: 180,
      child: Consumer<ProductListProvider>(
        builder: (context, productListProvider, child) {
          if (productListProvider.initialLoading) {
            return CenterCircularProgress();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productListProvider.products.length > 5
                ? 5
                : productListProvider.products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                productModel: productListProvider.products[index],
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildApppBar() {
    return AppBar(
      title: SvgPicture.asset(AppAssetsPath.appNavLogo),
      actions: [
        CircularIconButton(icon: Icons.person, onTap: () {}),
        SizedBox(width: 4),
        CircularIconButton(icon: Icons.call, onTap: () {}),
        SizedBox(width: 4),
        CircularIconButton(
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}

Widget _buildCategoryList() {
  return SizedBox(
    height: 95,
    child: Consumer<CategoryListProvider>(
      builder: (context, categoryListProvider, child) {
        if (categoryListProvider.initialLoading) {
          return CenterCircularProgress();
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categoryListProvider.categoryList.length > 10
              ? 10
              : categoryListProvider.categoryList.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              categoryModel: categoryListProvider.categoryList[index],
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 12),
        );
      },
    ),
  );
}
