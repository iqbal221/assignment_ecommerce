import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/sign_up_params.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/verify_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/snack_bar_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = "/sign-up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpProvider _signupProvider = SignUpProvider();

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create: (_) => _signupProvider,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  spacing: 10,
                  children: [
                    AppLogo(width: 80),
                    Text(
                      "Sign Up",
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Get started with your details",
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: "First Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: "Last Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
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
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter your password";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _phoneTEController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: "Phone"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your valid phone";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _cityTEController,
                      decoration: InputDecoration(hintText: "City"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your City";
                        }
                        return null;
                      },
                    ),
                    Consumer<SignUpProvider>(
                      builder: (context, signupProvider, child) {
                        return Visibility(
                          visible: signupProvider.isSignUpInProgress == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: FilledButton(
                            onPressed: _onTapSignUpButton,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyLarge,
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.themeColor,
                            ),
                            text: "SignIn",
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
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

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
    // Navigator.pushNamed(context, VerifyOTPScreen.name);
  }

  Future<void> _signUp() async {
    // final bool isSuccess = await _signupProvider.signUp(
    //   SignUpParams(
    //     firstName: _firstNameTEController.text.trim(),
    //     lastName: _lastNameTEController.text.trim(),
    //     email: _emailTEController.text.trim(),
    //     password: _passwordTEController.text,
    //     phone: _phoneTEController.text.trim(),
    //     city: _cityTEController.text.trim(),
    //   ),
    // );

    // if (isSuccess) {
    //   Navigator.pushNamed(
    //     context,
    //     VerifyOTPScreen.name,
    //     arguments: _emailTEController.text.trim(),
    //   );
    // } else {
    //   ShowSnackBarMessage(context, _signupProvider.errorMessage!);
    // }

    SignUpParams params = SignUpParams(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
      phone: _phoneTEController.text.trim(),
      city: _cityTEController.text.trim(),
    );

    final bool isSuccess = await _signupProvider.signUp(params);

    if (isSuccess) {
      Navigator.pushNamed(
        context,
        VerifyOTPScreen.name,
        arguments: _emailTEController.text.trim(),
      );
    } else {
      ShowSnackBarMessage(context, _signupProvider.errorMessage!);
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
