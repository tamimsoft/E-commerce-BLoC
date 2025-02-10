import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:fakestore/app/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:fakestore/app/utils/helper/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendOtpSection extends StatelessWidget {
  const ResendOtpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.status == Status.loaded) {
          AppSnackBar.success(
            context: context,
            title: 'Success',
            message: 'OTP sent successfully',
          );
        } else if (state.status == Status.error) {
          AppSnackBar.error(
            context: context,
            title: 'Error',
            message: state.errorMsg,
          );
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.remainingTime > 0)
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.grey),
                    text: AppString.otpExpireText,
                    children: [
                      TextSpan(
                        text: '${state.remainingTime}s',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Text('Don\'t received the code?'),
              TextButton(
                onPressed: state.remainingTime < 1
                    ? () {
                        context.read<OtpBloc>().add(OtpEventReSendOtpButton());
                      }
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    const Text('Resend Code'),
                    state.status == Status.loading
                        ? SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 2,
                            ))
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
