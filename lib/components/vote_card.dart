import 'package:flutter/material.dart';
import 'package:voting_system/utils/custom_colors.dart';

class VoteCard extends StatelessWidget {
  final Function() onVote;

  const VoteCard({Key? key, required this.onVote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        const Positioned(
          top: 90,
          child: SizedBox(
            width: 300,
            height: 210,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                shape: const CircleBorder(),
                elevation: 4,
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Border radius
                    child: ClipOval(
                      child: Image.asset(
                        'assets/default-placeholder.png',
                        width: 240,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Osvaldo Margato',
                style: textTheme.headline6?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 36,
                width: 250,
                child: ElevatedButton(
                  onPressed: onVote,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      CustomColors.green,
                    ),
                  ),
                  child: const Text('VOTAR'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
