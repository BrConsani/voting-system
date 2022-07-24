import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voting_system/pages/admin_page/components/create_candidate_dialog.dart';
import 'package:voting_system/shared/entity/candidate.dart';
import 'package:voting_system/shared/entity/voting.dart';

class CreateVoteDialog extends StatefulWidget {
  const CreateVoteDialog({Key? key}) : super(key: key);

  @override
  State<CreateVoteDialog> createState() => _CreateVoteDialogState();
}

class _CreateVoteDialogState extends State<CreateVoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final candidates = <Candidate>[];

  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Criar Votação'),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text('Nome')),
            ),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(label: Text('Imagem')),
            ),
            TextFormField(
              controller: _startDateController,
              decoration: const InputDecoration(label: Text('Data Inicio')),
              onTap: () => _onTapChooseDate(_startDateController),
              readOnly: true,
            ),
            TextFormField(
              controller: _endDateController,
              decoration: const InputDecoration(label: Text('Data Fim')),
              onTap: () => _onTapChooseDate(_endDateController),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Candidatos:'),
                ElevatedButton(
                  onPressed: _onTapCreateCandidate,
                  child: const Text('ADICIONAR'),
                )
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: candidates.map((candidate) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(candidate.name),
                    IconButton(
                      splashRadius: 24,
                      onPressed: () => _onTapRemoveCandidate(candidate),
                      icon: const Icon(Icons.delete),
                    )
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('CANCELAR')),
        TextButton(onPressed: _onTapCreate, child: const Text('CRIAR')),
      ],
    );
  }

  Future<void> _onTapChooseDate(TextEditingController controller) async {
    FocusScope.of(context).requestFocus(FocusNode());

    final choosedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (choosedDate == null) return;

    final choosedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (choosedTime == null) return;

    controller.text = DateTime(
      choosedDate.year,
      choosedDate.month,
      choosedDate.day,
      choosedTime.hour,
      choosedTime.minute,
    ).toString();
  }

  void _onTapRemoveCandidate(Candidate candidate) {
    setState(() => candidates.remove(candidate));
  }

  Future<void> _onTapCreateCandidate() async {
    final candidate = await Get.dialog(CreateCandidateDialog());

    if (candidate is Candidate) {
      setState(() => candidates.add(candidate));
    }
  }

  void _onTapCreate() {
    if (_formKey.currentState!.validate()) {
      Get.back(
        result: Voting(
          name: _nameController.text,
          imageUrl: _imageController.text,
          startDate: DateTime.parse(_startDateController.text),
          endDate: DateTime.parse(_startDateController.text),
          candidates: candidates,
          totalVotes: 0,
          open: false,
        ),
      );
    }
  }
}
