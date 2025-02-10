import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (current, previous) => current.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: AppString.passwordText),
          onChanged: (value) {
            context.read<SignupBloc>().add(SignupEventOnChangePassword(password: value));
          },
        );
      },
    );
  }
}
