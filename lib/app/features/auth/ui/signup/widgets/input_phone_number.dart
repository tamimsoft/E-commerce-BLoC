import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (current, previous) => current.phone != previous.phone,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: AppString.phoneText),
          onChanged: (value) {
            context.read<SignupBloc>().add(SignupEventOnChangePhone(phone: value));
          },
        );
      },
    );
  }
}
