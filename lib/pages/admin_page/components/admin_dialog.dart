import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDialog extends StatelessWidget {
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AdminDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed('/votes');
        return Future.value(false);
      },
      child: AlertDialog(
        title: const Text('Insira a senha de admin'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                obscureText: true,
                controller: passwordController,
                validator: (password) {
                  return password != 'admin123' ? 'Senha incorreta!' : null;
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed('/votes'),
            child: const Text('CANCELAR'),
          ),
          TextButton(onPressed: _onTapValidate, child: const Text('VALIDAR')),
        ],
      ),
    );
  }

  void _onTapValidate() {
    if (_formKey.currentState!.validate()) {
      Get.back(result: true);
    }
  }
}
