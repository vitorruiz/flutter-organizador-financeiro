import 'package:flutter/material.dart';

const double _buttonHeight = 48;

class PrimaryButton extends StatelessWidget {

  const PrimaryButton({super.key, this.onPressed, required this.text});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {

  const SecondaryButton({super.key, this.onPressed, required this.text});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
      child: Text(text),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {

  const PrimaryTextButton({super.key, this.onPressed, required this.text});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
      child: Text(text),
    );
  }
}

class ErrorTextButton extends StatelessWidget {

  const ErrorTextButton({super.key, this.onPressed, required this.text});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
      child: Text(text),
    );
  }
}
