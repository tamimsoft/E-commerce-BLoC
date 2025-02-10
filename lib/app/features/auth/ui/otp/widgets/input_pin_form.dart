import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/core/theme/custom/pin_theme.dart';
import 'package:fakestore/app/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class InputPinForm extends StatelessWidget {
  const InputPinForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Pinput(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
            //  FilteringTextInputFormatter.deny(RegExp(r'[,.\-]')), // Block specific characters
          ],
          keyboardType: TextInputType.number,
          length: AppString.otpLength,
          // validator: (value) {
          //   return controller.isValidOtp.value ? null : 'Pin is incorrect';
          // },

          onChanged: (value) => context.read<OtpBloc>().add(OtpEventOnChangeOtp(otp: value)),
          defaultPinTheme: CustomPinTheme.defaultTheme.copyBorderWith(
            border: Border.all(color: AppColors.grey),
          ),
          focusedPinTheme: CustomPinTheme.defaultTheme.copyBorderWith(
            border: Border.all(color: AppColors.primary),
          ),
          submittedPinTheme: CustomPinTheme.defaultTheme.copyBorderWith(
            border: Border.all(color: AppColors.primary),
          ),
          errorPinTheme: CustomPinTheme.defaultTheme.copyBorderWith(
            border: Border.all(color: Colors.redAccent),
          ),
        );
      },
    );
  }
}
