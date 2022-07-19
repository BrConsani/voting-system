import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                splashRadius: 24,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const Text('LOGIN'),
            const SizedBox(height: 32),
          ],
        ),
      ),
      content: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('CONECTAR COM O GOOGLE'),
        ),
      ),
    );
  }
}
