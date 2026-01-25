import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/models/network_response.dart';
import 'package:ecommerce_assignment_module_31/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductListProvider extends ChangeNotifier {
  bool _initialLoading = false;
  bool _loadingMoreData = false;

  bool get initialLoading => _initialLoading;
  bool get loadingMoreData => _loadingMoreData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  final int _pageSize = 30;
  int _currentPageNo = 0;
  int? _lastPageNo;

  Future<bool> fetchProductList() async {
    bool isSuccess = false;
    if (_currentPageNo == 0) {
      _productList.clear();
      _initialLoading = true;
    } else if (_currentPageNo <= _lastPageNo!) {
      _loadingMoreData = true;
    } else {
      return false;
    }
    notifyListeners();
    _currentPageNo++;

    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.productListUrl(_pageSize, _currentPageNo),
    );

    if (response.isSuccess) {
      _lastPageNo ??= response.responseData["data"]["last_page"];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData
          in response.responseData["data"]["results"]) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_initialLoading) {
      _initialLoading = false;
    } else {
      _loadingMoreData = false;
    }

    notifyListeners();

    return isSuccess;
  }

  Future<void> refreshProductList() async {
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchProductList();
  }
}
