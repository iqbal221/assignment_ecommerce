import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/verify_screen.dart';
import 'package:ecommerce_assignment_module_31/features/common/screens/main_nav_holder_screen.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    Widget widget = SizedBox();

    if (settings.name == SplashScreen.name) {
      widget = SplashScreen();
    } else if (settings.name == SignUpScreen.name) {
      widget = SignUpScreen();
    } else if (settings.name == SignInScreen.name) {
      widget = SignInScreen();
    } else if (settings.name == VerifyOTPScreen.name) {
      widget = VerifyOTPScreen(email: settings.arguments as String);
    } else if (settings.name == MainNavHolderScreen.name) {
      widget = MainNavHolderScreen();
    }
    // } else if (settings.name == SignUpScreen.name) {
    //   widget = SignUpScreen();}
    // } else if (settings.name == SignInScreen.name) {
    //   widget = SignInScreen();
    // } else if (settings.name == VerifyOTPScreen.name) {
    //   final email = settings.arguments as String;
    //   widget = VerifyOTPScreen(email: email);
    // } else if (settings.name == MainNavHolderScreen.name) {
    //   widget = MainNavHolderScreen();
    // } else if (settings.name == ProductListByCategoryScreen.name) {
    //   final categoryModel = settings.arguments as CategoryModel;
    //   widget = ProductListByCategoryScreen(categoryModel: categoryModel);
    // } else if (settings.name == ProductDetailsScreen.name) {
    //   final productId = settings.arguments as String;
    //   widget = ProductDetailsScreen(productId: productId);
    // }

    return MaterialPageRoute(builder: (ctx) => widget);
  }
}
