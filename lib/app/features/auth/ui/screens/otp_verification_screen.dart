import 'package:fakestore/app/features/auth/ui/widgets/widgets.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';


class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 140),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              const AppLogoWidget(),
              const FormHeader(
                title: AppString.otpScreenTitleText,
                subTitle: AppString.otpScreenSubTitleText,
              ),
              InputPinForm(),
              OTPVerificationButton(),
              ResendOtpSection(),
            ],
          ),
        ),
      ),
    );
  }
}
