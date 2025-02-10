import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: AppString.emailText,
            prefixIcon: Icon(Icons.email_outlined),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEventOnChangeEmail(email: value));
          },
        );
      },
    );
  }
}
