import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../utils/helper/snack_bar.dart';
import '../bloc/auth_bloc.dart';

class ResendOtpSection extends StatelessWidget {
  const ResendOtpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpReSent) {
          AppSnackBar.success(
            context: context,
            title: 'Success',
            message: 'OTP sent successfully',
          );
        } else if (state.status == AuthStatus.error) {
          AppSnackBar.error(
            context: context,
            title: 'Error',
            message: state.errorMsg,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
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
                        context.read<AuthBloc>().add(AuthEventReSendEmailVerifyButton());
                      }
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    const Text('Resend Code'),
                    state.status == AuthStatus.loadingTexBtn
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
