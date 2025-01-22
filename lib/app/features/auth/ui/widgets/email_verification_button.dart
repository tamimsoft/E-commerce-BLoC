import 'package:ecommerce2/app/features/auth/ui/bloc/auth_bloc.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:ecommerce2/app/utils/helper/functions.dart';
import 'package:ecommerce2/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmailVerificationButton extends StatelessWidget {
  const EmailVerificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty) {
          AppSnackBar.error(context: context, message: state.errorMsg);
        }
        if (state.status == AuthStatus.otpSent) {
          Navigator.pushNamed(context, RoutesName.otpVerify);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.status == AuthStatus.loading || state.email.isEmpty
                ? null
                : () => context.read<AuthBloc>().add(AuthEventEmailVerifyButton()),
            child: state.status == AuthStatus.loading ? buttonLoading() : const Text('Next'),
          );
        },
      ),
    );
  }
}
