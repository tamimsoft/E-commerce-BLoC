import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/features/auth/ui/welcome/cubit/welcome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit()..checkAuthentication(),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listener: (BuildContext context, state) {
         if (state.isAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (_) => false);
          });
        } else if (!state.isAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (_) => false);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
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
        );
      },
    );
  }
}
