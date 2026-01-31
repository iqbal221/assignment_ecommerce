import 'package:ecommerce_assignment_module_31/features/category/data/models/category_model.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/product_card.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_list_by_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryModel});

  static const String name = "/product-list-by-category";

  final CategoryModel categoryModel;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  final ProductListByCategoryProvider _productListByCategoryProvider =
      ProductListByCategoryProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListByCategoryProvider.loadInitialProductList(
        widget.categoryModel.id,
      );
      _scrollController.addListener(_loadMoreData);
    });
  }

  void _loadMoreData() {
    if (_productListByCategoryProvider.moreLoading) {
      return;
    }
    if (_scrollController.position.extentBefore < 300) {
      _productListByCategoryProvider.fetchProductList(widget.categoryModel.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryModel.title)),
      body: ChangeNotifierProvider(
        create: (_) => _productListByCategoryProvider,
        child: Consumer<ProductListByCategoryProvider>(
          builder: (context, productListByCategoryProvider, _) {
            if (productListByCategoryProvider.initialLoading) {
              return CenterCircularProgress();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: productListByCategoryProvider.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product =
                      productListByCategoryProvider.productList[index];
                  return FittedBox(child: ProductCard(productModel: product));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
