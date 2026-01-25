import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/sign_in_params.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/sign_in_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce_assignment_module_31/features/common/screens/main_nav_holder_screen.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = "/sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInProvider _signInProvider = SignInProvider();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create: (_) => _signInProvider,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    AppLogo(width: 80),
                    Text(
                      "Sign In",

                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Login to your account with email and password",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your valid email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter your password";
                        }
                        return null;
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _onTapForgetPassword,
                          child: Text("Forget Password"),
                        ),
                      ],
                    ),

                    Consumer<SignInProvider>(
                      builder: (context, signInProvider, child) {
                        if (signInProvider.isSignInProgress == true) {
                          return CenterCircularProgress();
                        } else {
                          return FilledButton(
                            onPressed: _onTapSignInButton,
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyLarge,
                        text: "Need an account? ",
                        children: [
                          TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.themeColor,
                            ),
                            text: "SignUp",
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUpButton,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapForgetPassword() {}

  void _onTapSignUpButton() {
    Navigator.pop(context);
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    SignInParams params = SignInParams(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );

    final bool isSuccess = await _signInProvider.signIn(params);

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavHolderScreen.name,
        (predicate) => false,
      );
    } else {
      ShowSnackBarMessage(context, _signInProvider.errorMessage!);
    }
  }
}
