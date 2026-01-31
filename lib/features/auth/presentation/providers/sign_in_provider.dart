import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/services/network_caller.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/sign_in_params.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/user_model.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  bool _isSignInProgress = false;

  bool get isSignInProgress => _isSignInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {
    bool isSucess = false;

    _isSignInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.signInUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(
        response.responseData["data"]['user'],
      );
      String accessToken = response.responseData["data"]['token'];
      await AuthController.saveUserData(accessToken, userModel);
      isSucess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isSignInProgress = false;
    notifyListeners();

    return isSucess;
  }
}
