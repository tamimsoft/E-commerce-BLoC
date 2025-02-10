import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:fakestore/app/features/auth/ui/login/widgets/input_email.dart';
import 'package:fakestore/app/features/auth/ui/login/widgets/input_password.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/login/widgets/login_button.dart';
import 'package:fakestore/app/features/auth/ui/login/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 140),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const AppLogoWidget(),
            const FormHeader(
              title: AppString.loginScreenTitleText,
              subTitle: AppString.loginScreenSubTitleText,
            ),
            InputEmail(),
            InputPassword(),
            LoginButton(),
            CustomDivider(),
            const SocialLoginButton(),
            _buildSignupSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppString.dontHaveAccountText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.signup);
            },
            child: Text(
              AppString.signUpText,
            ))
      ],
    );
  }
}
