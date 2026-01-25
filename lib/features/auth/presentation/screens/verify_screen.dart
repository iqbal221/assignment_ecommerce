import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/verify_otp_params.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_assignment_module_31/features/auth/presentation/widgets/app_logo.dart';
import 'package:ecommerce_assignment_module_31/features/common/widgets/center_cercular_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  static const String name = "/verify-otp";
  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  TextTheme get textTheme => TextTheme.of(context);

  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyOtpProvider(),
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
                      "Verify OTP",
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "A 4 digit OTP has been sent to your email",
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    PinCodeTextField(
                      length: 4,
                      controller: _otpTEController,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 70,
                        activeFillColor: Colors.white,
                      ),
                      backgroundColor: Colors.transparent,
                      appContext: context,
                    ),
                    // SizedBox(height: 10),
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        if (_verifyOtpProvider.isVerifyOtpInProgress) {
                          return CenterCircularProgress();
                        }
                        return FilledButton(
                          onPressed: _onTapVerifyButton,
                          child: Text('Verify OTP'),
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

  void _onTapSignInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _onTapVerifyButton() {
    if (_formKey.currentState!.validate()) {
      // Perform OTP verification logic here
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    VerifyOtpParams params = VerifyOtpParams(
      email: widget.email,
      otp: _otpTEController.text,
    );

    final bool isSuccess = await _verifyOtpProvider.verifyOtp(params);

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
        (predicate) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_verifyOtpProvider.errorMessage!)));
    }
  }
}
