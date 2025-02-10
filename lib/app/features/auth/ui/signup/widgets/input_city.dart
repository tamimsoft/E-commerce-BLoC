import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputCity extends StatelessWidget {
  const InputCity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (current, previous) => current.city != previous.city,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: AppString.cityText),
          onChanged: (value) {
            context.read<SignupBloc>().add(SignupEventOnChangeCity(city: value));
          },
        );
      },
    );
  }
}
