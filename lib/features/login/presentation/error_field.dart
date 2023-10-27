import 'package:flutter/material.dart';

class ErrorField extends StatelessWidget {
  const ErrorField({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error);
    const duration = Duration(milliseconds: 200);

    return AnimatedOpacity(
      opacity: message == null ? 0 : 1,
      duration: duration,
      child: Text(message ?? '', style: textStyle),
    );
  }
}
