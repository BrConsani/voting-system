import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voting_system/pages/vote_page/vote_controller.dart';

import '../../shared/components/app_bar_icon_button.dart';
import '../../shared/components/login_dialog.dart';
import 'components/success_dialog.dart';
import 'components/vote_card.dart';

class VotePage extends StatelessWidget {
  final controller = VoteController();

  VotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          AppBarIconButton(
            icon: Icons.thumb_up_alt,
            text: 'Votações',
            onTap: () => Get.toNamed('/votes'),
          ),
          const SizedBox(width: 16),
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
              'Votação para Dev do Mês',
              style: textTheme.headline2?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: getFlexCount(constraints),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: getCrossAxisCount(constraints),
                      shrinkWrap: true,
                      children: List.generate(9, (_) {
                        return Center(
                          child: VoteCard(
                            description: 'Osvaldo Margato',
                            imageUrl:
                                'https://media-exp1.licdn.com/dms/image/C4D03AQF2r57YHXg6Dw/profile-displayphoto-shrink_800_800/0/1581707593799?e=1663804800&v=beta&t=nkNyEwhT3lbCTSajtl4P6-qd1TDOP4dOSMH95NuzUpA',
                            onVote: _onTapVote,
                            actionText: 'VOTAR',
                          ),
                        );
                      }),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              );
            },
          ),
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

  Future<void> _onTapVote() async {
    await controller.computeVote();
    Get.dialog(const SuccessDialog());
  }

  Future<void> _onTapLogin() async {
    Get.dialog(const LoginDialog());
  }
}
