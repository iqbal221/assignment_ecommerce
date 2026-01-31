import 'package:ecommerce_assignment_module_31/app/app_routes.dart';
import 'package:ecommerce_assignment_module_31/app/app_theme.dart';
import 'package:ecommerce_assignment_module_31/app/providers/language_provider.dart';
import 'package:ecommerce_assignment_module_31/app/providers/theme_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecommerce_assignment_module_31/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/category/presentation/providers/category_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/providers/home_slider_provider.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/wishlist/presentation/providers/wish_list_provider.dart';
import 'package:ecommerce_assignment_module_31/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class EcommerceAssignment extends StatefulWidget {
  const EcommerceAssignment({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<EcommerceAssignment> createState() => _EcommerceAssignmentState();
}

class _EcommerceAssignmentState extends State<EcommerceAssignment> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => LanguageProvider()..loadInitialLanguage(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider()..loadInitialThemeMode(),
        ),
        ChangeNotifierProvider(create: (_) => MainNavContainerProvider()),
        ChangeNotifierProvider(create: (_) => CategoryListProvider()),
        ChangeNotifierProvider(create: (_) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),
        ChangeNotifierProvider(create: (_) => CartListProvider()),
        ChangeNotifierProvider(create: (_) => WishListProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                navigatorKey: EcommerceAssignment.navigatorKey,
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.currentThemeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en'), // English
                  Locale('bn'), // Spanish
                  Locale('fr'), // France
                ],
                locale: languageProvider.currentLocale,
              );
            },
          );
        },
      ),
    );
  }
}
