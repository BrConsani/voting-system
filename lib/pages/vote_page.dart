import 'package:flutter/material.dart';
import 'package:voting_system/components/vote_card.dart';

class VotePage extends StatelessWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icons.thumb_up_alt,
            text: 'Votações',
            onTap: () {},
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: Icons.settings,
            text: 'Gerenciar',
            onTap: () {},
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                side: MaterialStateProperty.all(const BorderSide()),
                overlayColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
              ),
              child: const Text('LOGIN'),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Votação para Dev do Mês',
              style: textTheme.headline2?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 36),
          Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 5,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: getCrossAxisCount(constraints),
                      shrinkWrap: true,
                      children: List.generate(9, (_) {
                        return const Center(child: VoteCard());
                      }),
                    );
                  },
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 900) {
      return 3;
    } else if (constraints.maxWidth > 600) {
      return 2;
    } else {
      return 1;
    }
  }
}

class IconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const IconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            Text(text),
          ],
        ),
      ),
    );
  }
}
