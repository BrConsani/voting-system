import 'package:flutter/material.dart';

import '../../../shared/utils/custom_colors.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  late AssetImage _imageAsset;

  @override
  void initState() {
    super.initState();
    _imageAsset = const AssetImage('assets/success.gif');
  }

  @override
  void dispose() {
    _imageAsset.evict();
    super.dispose();
  }

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
            Image(image: _imageAsset, width: 200, height: 200),
            const Text('Mandou bem!'),
          ],
        ),
      ),
      content: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            CustomColors.green,
          ),
        ),
        child: const Text('COMPARTILHAR'),
      ),
    );
  }
}
