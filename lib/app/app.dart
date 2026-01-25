import 'package:ecommerce_assignment_module_31/app/app_routes.dart';
import 'package:ecommerce_assignment_module_31/app/app_theme.dart';
import 'package:ecommerce_assignment_module_31/app/providers/language_provider.dart';
import 'package:ecommerce_assignment_module_31/app/providers/theme_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecommerce_assignment_module_31/features/category/presentation/providers/category_list_provider.dart';
import 'package:ecommerce_assignment_module_31/features/common/providers/main_nav_container_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/providers/home_slider_provider.dart';
import 'package:ecommerce_assignment_module_31/features/home/presentation/widgets/home_carousel_slider.dart';
import 'package:ecommerce_assignment_module_31/features/product/presentation/providers/product_list_provider.dart';
import 'package:ecommerce_assignment_module_31/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class EcommerceAssignment extends StatelessWidget {
  const EcommerceAssignment({super.key});

  // This widget is the root of your application.
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
        ChangeNotifierProvider(create: (ctx) => MainNavContainerProvider()),
        ChangeNotifierProvider(create: (ctx) => HomeSliderProvider()),
        ChangeNotifierProvider(create: (ctx) => CategoryListProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductListProvider()),
      ],

      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return MaterialApp(
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.routes,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.currentThemeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [Locale('en'), Locale('bn'), Locale('de')],
                locale: languageProvider.currentLocale,
              );
            },
          );
        },
      ),
    );
  }
}
