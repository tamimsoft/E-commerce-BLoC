
import 'package:flutter/material.dart';

class SocialSignupButton extends StatelessWidget {
  const SocialSignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 16,
      children: [
        _buildButton(
          label: 'Facebook',
          icon: Icons.facebook,
          onPressed: () {},
        ),
        _buildButton(
          label: 'Google',
          icon: Icons.g_mobiledata,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: OutlinedButton.icon(
        label: Text(label),
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}