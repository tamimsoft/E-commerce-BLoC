import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:fakestore/app/features/auth/ui/signup/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            const AppLogoWidget(),
            const FormHeader(
              title: AppString.signupScreenTitleText,
              subTitle: AppString.signupScreenSubTitleText,
            ),
            InputFirstName(),
            InputLastName(),
            InputEmail(),
            InputPassword(),
            InputPhoneNumber(),
            InputCity(),
            SignupButton(),
            CustomDivider(),
            const SocialSignupButton(),
            _buildLoginSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppString.alreadyHaveAccountText),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(AppString.loginText),
        ),
      ],
    );
  }
}
