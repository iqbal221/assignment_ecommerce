import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/services/network_caller.dart';
import 'package:ecommerce_assignment_module_31/features/cart/data/modals/cart_list_model.dart';
import 'package:flutter/material.dart';

class CartListProvider extends ChangeNotifier {
  bool _cartListInProgress = false;

  bool get cartListInProgress => _cartListInProgress;

  final List<CartListModel> _cartList = [];

  List<CartListModel> get cartList => _cartList;

  int get totalPrice {
    int total = 0;
    for (final item in cartList) {
      total += item.currentPrice * item.quantity;
    }
    return total;
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(String productId) async {
    bool isSuccess = false;

    _cartListInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {"product": productId};

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.cartListUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _cartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> fetchCartList() async {
    bool isSuccess = false;

    _cartListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.cartListUrl,
    );
    if (response.isSuccess) {
      cartList.clear();
      List<CartListModel> list = [];
      for (Map<String, dynamic> jsonData
          in response.responseData['data']['results']) {
        list.add(CartListModel.fromJson(jsonData));
      }

      _cartList.addAll(list);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _cartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> deleteCartItem(String productId) async {
    bool isSuccess = false;

    _cartListInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().deleteRequest(
      url: Urls.deleteCartItemUrl(productId),
    );

    if (response.isSuccess) {
      _cartList.removeWhere((item) => item.id == productId);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _cartListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
