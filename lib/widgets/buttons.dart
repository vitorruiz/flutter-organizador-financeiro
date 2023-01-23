import 'package:flutter/material.dart';

const double _buttonHeight = 48;

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({Key? key, this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({Key? key, this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryTextButton({Key? key, this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
    );
  }
}

class ErrorTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const ErrorTextButton({Key? key, this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
        minimumSize: const Size.fromHeight(_buttonHeight),
      ),
    );
  }
}
