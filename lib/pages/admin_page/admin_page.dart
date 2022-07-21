import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/app_bar_icon_button.dart';
import '../vote_page/components/vote_card.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          AppBarIconButton(
            icon: Icons.add,
            text: 'Nova Votação',
            onTap: () {},
          ),
          const SizedBox(width: 16),
          AppBarIconButton(
            icon: Icons.thumb_up_alt,
            text: 'Votações',
            onTap: () => Get.toNamed('/votes'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Votações',
              style: textTheme.headline2?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: getFlexCount(constraints),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: getCrossAxisCount(constraints),
                    shrinkWrap: true,
                    children: List.generate(1, (_) {
                      return Center(
                        child: VoteCard(
                          description: 'Dev do Mês',
                          imageUrl:
                              'https://store-images.microsoft.com/image/apps.43285.9007199266246620.41cf6c7d-02b1-4f98-acd2-4d40fb8d4a26.472c4392-fadf-4711-9f8b-62df0ed34905',
                          onVote: () async {},
                          actionText: 'VISUALIZAR',
                        ),
                      );
                    }),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            );
          }),
        ],
      ),
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1100) {
      return 3;
    } else if (constraints.maxWidth > 850) {
      return 2;
    } else {
      return 1;
    }
  }

  int getFlexCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1100) {
      return 10;
    } else if (constraints.maxWidth > 850) {
      return 5;
    } else {
      return 3;
    }
  }
}
