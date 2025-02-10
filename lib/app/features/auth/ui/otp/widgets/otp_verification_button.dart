import 'package:fakestore/app/common/widgets/button_progress_indicator.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:fakestore/app/utils/helper/functions.dart';
import 'package:fakestore/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.status == Status.error) {
          AppSnackBar.error(context: context, message: state.errorMsg);
        }
        if (state.status == Status.loaded) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (_) => false);
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.status == Status.loading || state.otp.isEmpty
                ? null
                : () => context.read<OtpBloc>().add(OtpEventVerifyButton()),
            child: state.status == Status.loading ? ButtonProgressIndicator() : const Text('Next'),
          );
        },
      ),
    );
  }
}
