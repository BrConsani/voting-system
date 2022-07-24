import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_system/pages/list_page/list_controller.dart';

import '../../shared/components/app_bar_icon_button.dart';
import '../../shared/components/login_dialog.dart';
import '../vote_page/components/vote_card.dart';

class ListPage extends StatelessWidget {
  final controller = Get.put(ListController());

  ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          AppBarIconButton(
            icon: Icons.settings,
            text: 'Gerenciar',
            onTap: () => Get.toNamed('/admin'),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: _onTapLogin,
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
                  child: Obx(() {
                    return GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: getCrossAxisCount(constraints),
                      shrinkWrap: true,
                      children: controller.votings.map((voting) {
                        return Center(
                          child: VoteCard(
                            description: voting.name,
                            imageUrl: voting.imageUrl,
                            onVote: voting.open
                                ? () async => Get.toNamed('/votes/${voting.id}')
                                : null,
                            actionText: 'VOTAR',
                          ),
                        );
                      }).toList(),
                    );
                  }),
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

  Future<void> _onTapLogin() async {
    Get.dialog(const LoginDialog());
  }
}
