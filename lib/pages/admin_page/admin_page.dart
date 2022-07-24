import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_system/pages/admin_page/admin_controller.dart';
import 'package:voting_system/pages/admin_page/components/create_vote_dialog.dart';
import 'package:voting_system/shared/components/result_dialog.dart';
import 'package:voting_system/shared/entity/voting.dart';

import '../../shared/components/app_bar_icon_button.dart';
import '../vote_page/components/vote_card.dart';

class AdminPage extends StatelessWidget {
  final controller = Get.put(AdminController());

  AdminPage({Key? key}) : super(key: key);

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
            onTap: _onTapOnCreate,
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
          LayoutBuilder(
            builder: (context, constraints) {
              return Expanded(
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
                          subtitle: voting.winner != null
                              ? 'Vencedor: ${voting.winner!.name}'
                              : null,
                          imageUrl: voting.imageUrl,
                          onVote: () async {
                            Get.dialog(ResultDialog(voting: voting));
                          },
                          actionText: 'VISUALIZAR',
                        ),
                      );
                    }).toList(),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  _onTapOnCreate() async {
    final voting = await Get.dialog<Voting>(const CreateVoteDialog());

    if (voting != null) controller.createVoting(voting);
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
