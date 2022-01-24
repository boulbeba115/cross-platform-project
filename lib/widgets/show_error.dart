import 'package:flutter/material.dart';

class ShowError extends StatelessWidget {
  final String title;
  final String content;
  const ShowError({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.orange),
              )),
        )
      ],
    );
  }
}
