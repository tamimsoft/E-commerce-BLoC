import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/app_strings.dart';
import '../bloc/auth_bloc.dart';

class InputEmailTextField extends StatelessWidget {
  const InputEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (current, previous) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: AppString.emailText),
          onChanged: (value) {
            context.read<AuthBloc>().add(AuthEventEmailChange(email: value));
          },
        );
      },
    );
  }
}
