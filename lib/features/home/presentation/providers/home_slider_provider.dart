import 'package:ecommerce_assignment_module_31/app/set_up_network_caller.dart';
import 'package:ecommerce_assignment_module_31/app/urls.dart';
import 'package:ecommerce_assignment_module_31/core/models/network_response.dart';
import 'package:ecommerce_assignment_module_31/features/home/data/models/slider_model.dart';
import 'package:flutter/material.dart';

class HomeSliderProvider extends ChangeNotifier {
  bool _getHomeSliderInProgress = false;

  bool get getHomeSliderInProgress => _getHomeSliderInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<SliderModel> _homeSliders = [];
  List<SliderModel> get homeSliders => _homeSliders;

  Future<bool> getHomeSliders() async {
    bool isSuccess = false;

    _getHomeSliderInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      url: Urls.homeSlidersUrl,
    );

    if (response.isSuccess) {
      List<SliderModel> sliders = [];
      for (Map<String, dynamic> slider
          in response.responseData["data"]["results"]) {
        sliders.add(SliderModel.fromJson(slider));
      }
      _homeSliders = sliders;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getHomeSliderInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
