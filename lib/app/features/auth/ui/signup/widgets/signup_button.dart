import 'package:fakestore/app/common/widgets/button_progress_indicator.dart';
import 'package:fakestore/app/config/routes/routes_name.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:fakestore/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) => previous.errorMsg != current.errorMsg,
      listener: (context, state) {
        if (state.status == Status.error && state.errorMsg.isNotEmpty) {
          AppSnackBar.error(context: context, message: state.errorMsg);
        }
        if (state.status == Status.success) {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.otpVerify, (route) => false);
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return ElevatedButton(
            onPressed:
                state.status != Status.valid ? null : () => context.read<SignupBloc>().add(SignupEventSignupButton()),
            child: state.status == Status.loading ? ButtonProgressIndicator() : const Text('Next'),
          );
        },
      ),
    );
  }
}
