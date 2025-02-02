import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../../utils/helper/functions.dart';
import '../../../../utils/helper/snack_bar.dart';
import '../bloc/auth_bloc.dart';

class OTPVerificationButton extends StatefulWidget {
  const OTPVerificationButton({
    super.key,
  });

  @override
  State<OTPVerificationButton> createState() => _OTPVerificationButtonState();
}

class _OTPVerificationButtonState extends State<OTPVerificationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          AppSnackBar.error(context: context, message: state.errorMsg);
        }
        if (state.status == AuthStatus.otpVerified) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainScreen, (_) => false);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.status == AuthStatus.loading || state.otp.isEmpty
                ? null
                : () => context.read<AuthBloc>().add(AuthEventOtpVerifyButton()),
            child: state.status == AuthStatus.loading ? buttonLoading() : const Text('Next'),
          );
        },
      ),
    );
  }
}
