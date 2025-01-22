import 'dart:async';

import 'package:ecommerce2/app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:ecommerce2/app/features/auth/ui/widgets/widgets.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventCheckAuth());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        /// TODO: Handle auth status
        if (state.status == AuthStatus.loading) {
          Timer(Duration(seconds: 3), () {
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainScreen, (_) => false);
          });
        }

        // if (state.status == AuthStatus.loaded) {
        //   Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainScreen, (_) => false);
        // }
        // if (state.status == AuthStatus.error) {
        //   Navigator.pushNamed(context, RoutesName.login);
        // }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              AppLogoWidget(height: 150, width: 160),
              Spacer(flex: 1),
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Version 1.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
