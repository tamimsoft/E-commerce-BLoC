import 'package:ecommerce2/app/features/checkout/ui/bloc/checkout_bloc.dart';
import 'package:ecommerce2/app/routes/routes_name.dart';
import 'package:ecommerce2/app/utils/helper/dialog_box.dart';
import 'package:ecommerce2/app/utils/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: BlocProvider(
        create: (context) => CheckoutBloc(),
        child: BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              buildLoginDialog(context);
            } else if (state.status == Status.success) {
              showCustomDialog(
                context: context,
                title: 'Congratulation!',
                icon: Icons.check_circle,
                content: '"Your continued attention to my work means a lot—thank you."',
                confirmBtnLabel: 'OK',
                onConfirm: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(RoutesName.login);
                },
              );
            }
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CheckoutBloc>().add(CheckoutEventCheckout());
                },
                child: state.status == Status.loading ? buttonLoading() : const Text('Checkout'),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildLoginDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: Text('Please login to complete your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context, rootNavigator: true).pushNamed(RoutesName.login);
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
