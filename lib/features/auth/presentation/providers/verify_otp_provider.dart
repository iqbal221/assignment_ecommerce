import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/models/network_response.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/verify_otp_params.dart';
import 'package:flutter/material.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _isVerifyOtpInProgress = false;

  bool get isVerifyOtpInProgress => _isVerifyOtpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(VerifyOtpParams params) async {
    bool isSucess = false;

    _isVerifyOtpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      url: Urls.verifyOtpUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSucess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isVerifyOtpInProgress = false;
    notifyListeners();

    return isSucess;
  }
}
