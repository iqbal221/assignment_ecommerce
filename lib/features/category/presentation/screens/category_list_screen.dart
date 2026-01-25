import 'package:ecommerce_assignment_module_31/features/category/presentation/providers/category_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/category_card.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (context.read<CategoryListProvider>().loadingMoreData) {
      return;
    }

    if (_scrollController.position.extentBefore < 300) {
      context.read<CategoryListProvider>().fetchCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        context.read<MainNavContainerProvider>().backToHome();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              context.read<MainNavContainerProvider>().backToHome();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          title: Text("Categories"),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, child) {
            if (categoryListProvider.initialLoading) {
              return CenterCircularProgress();
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: categoryListProvider.categoryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          categoryModel:
                              categoryListProvider.categoryList[index],
                        );
                      },
                    ),
                  ),
                ),
                if (categoryListProvider.loadingMoreData)
                  CenterCircularProgress(),
              ],
            );
          },
        ),
      ),
    );
  }
}
