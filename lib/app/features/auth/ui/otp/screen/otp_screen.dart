import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:fakestore/app/features/auth/ui/otp/widgets/input_pin_form.dart';
import 'package:fakestore/app/features/auth/ui/otp/widgets/otp_verification_button.dart';
import 'package:fakestore/app/features/auth/ui/otp/widgets/resend_otp_section.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
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
