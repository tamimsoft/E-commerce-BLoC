import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: AppString.passwordText,
            prefixIcon: Icon(Icons.fingerprint),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEventOnChangePassword(password: value));
          },
        );
      },
    );
  }
}
