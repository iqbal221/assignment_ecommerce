import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/user_controller_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce_assignment_module_31/features/common/screens/main_nav_holder_screen.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }

  //  @override
  // void initState() {
  //   _moveToNextScreen();
  //   super.initState();
  // }

  // Future<void> _moveToNextScreen() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   await AuthController.getUserData();
  //   Navigator.pushNamedAndRemoveUntil(
  //     context,
  //     MainNavHolderScreen.name,
  //     (predicate) => false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
