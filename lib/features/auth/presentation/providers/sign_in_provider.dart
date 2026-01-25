import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/models/network_response.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/sign_in_params.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  bool _isSignInProgress = false;
  bool get isSignInProgress => _isSignInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {
    bool isSuccess = false;

    _isSignInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.signIn,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isSignInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
