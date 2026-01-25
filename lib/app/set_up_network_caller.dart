import 'package:ecommerce_assignment_module_31/core/services/network_caller.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';

NetworkCaller getNetworkCaller() {
  NetworkCaller networkCaller = NetworkCaller(
    onUnauthorized: () {},
    headers: {
      "content-type": "application/json",
      "token": AuthController.accessToken ?? "",
    },
  );

  return networkCaller;
}
