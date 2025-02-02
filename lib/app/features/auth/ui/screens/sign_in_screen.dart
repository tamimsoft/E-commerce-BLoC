import 'package:fakestore/app/features/auth/ui/widgets/widgets.dart';
import 'package:fakestore/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 140),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const AppLogoWidget(),
            const FormHeader(
              title: AppString.signInScreenTitleText,
              subTitle: AppString.signInScreenSubTitleText,
            ),
            InputEmailTextField(),
            EmailVerificationButton(),
            // ElevatedButton(
            //   onPressed: () {
            //     // Show OTPVerificationScreen as Modal Bottom Sheet
            //     showModalBottomSheet(
            //
            //       context: context,
            //       isScrollControlled: true, // Adjusts bottom sheet size
            //       builder: (context) {
            //         return BlocProvider.value(
            //           value: context.read<AuthBloc>(),
            //           child: FractionallySizedBox(
            //             widthFactor: 1,
            //             heightFactor: 0.7,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               spacing: 16,
            //               children: [
            //                 const FormHeader(
            //                   title: AppString.otpScreenTitleText,
            //                   subTitle: AppString.otpScreenSubTitleText,
            //                 ),
            //                 InputPinForm(),
            //                 OTPVerificationButton(),
            //                 ResendOtpSection(),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   child: const Text('Open OTP Screen'),
            // ),
          ],
        ),
      ),
    );
  }
}

