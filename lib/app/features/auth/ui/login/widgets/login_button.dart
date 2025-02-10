import 'package:fakestore/app/common/widgets/button_progress_indicator.dart';
import 'package:fakestore/app/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:fakestore/app/utils/helper/functions.dart';
import 'package:fakestore/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.errorMsg != current.errorMsg,
      listener: (context, state) {
        if (state.errorMsg.isNotEmpty) {
          AppSnackBar.error(context: context, message: state.errorMsg);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.status == Status.loading || (state.email.isEmpty || state.password.isEmpty)
                ? null
                : () => context.read<LoginBloc>().add(LoginEventLoginButton()),
            child: state.status == Status.loading ? ButtonProgressIndicator() : const Text('Next'),
          );
        },
      ),
    );
  }
}
