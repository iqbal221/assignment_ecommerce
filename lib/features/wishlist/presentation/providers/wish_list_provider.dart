import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/services/network_caller.dart';
import 'package:ecommerce_assignment_module_31/features/product/data/models/product_model.dart';
import 'package:flutter/foundation.dart';

class WishListProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPageNo = 0;

  int? _lastPageNo;

  bool _initialLoading = false;

  bool _loadingMoreData = false;

  final List<ProductModel> _wishList = [];

  String? _errorMessage;

  List<ProductModel> get wishList => _wishList;
  bool get initialLoading => _initialLoading;

  bool get moreLoading => _loadingMoreData;

  String? get errorMessage => _errorMessage;

  Future<bool> fetchWishlist() async {
    bool isSuccess = false;

    if (_currentPageNo == 0) {
      _wishList.clear();
      _initialLoading = true;
    } else if (_currentPageNo < _lastPageNo!) {
      _loadingMoreData = true;
    } else {
      return false;
    }
    notifyListeners();

    _currentPageNo++;
    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.wishListUrl(_pageSize, _currentPageNo),
    );
    if (response.isSuccess) {
      _lastPageNo ??= response.responseData['data']['last_page'];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData
          in response.responseData['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _wishList.addAll(list);
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

  Future<void> loadInitialWishlist() async {
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchWishlist();
  }
}
