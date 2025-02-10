import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: AppString.emailText),
          onChanged: (value) {
            context.read<SignupBloc>().add(SignupEventOnChangeEmail(email: value));
          },
        );
      },
    );
  }
}
