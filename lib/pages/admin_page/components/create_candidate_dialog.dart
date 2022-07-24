import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voting_system/shared/entity/candidate.dart';

class CreateCandidateDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  CreateCandidateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('CRIAR CANDIDATO'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text('Nome')),
              validator: _onValidateName,
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(label: Text('Imagem')),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('CANCELAR')),
        TextButton(onPressed: _onTapCreateButton, child: const Text('CRIAR')),
      ],
    );
  }

  void _onTapCreateButton() {
    if (_formKey.currentState!.validate()) {
      Get.back(
        result: Candidate(
          name: _nameController.text,
          imageUrl: _imageController.text,
          votes: 0,
        ),
      );
    }
  }

  String? _onValidateName(value) => value?.isNotEmpty == true
      ? null
      : 'É necessário dar um nome ao candidato';
}
