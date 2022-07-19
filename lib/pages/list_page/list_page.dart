import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../shared/components/app_bar_icon_button.dart';
import '../../shared/components/login_dialog.dart';
import '../vote_page/components/vote_card.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

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
            onTap: () {},
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
                      children: List.generate(1, (_) {
                        return Center(
                          child: VoteCard(
                            onVote: () async {
                              Get.toNamed('/votes/1');
                            },
                          ),
                        );
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

  Future<void> _onTapLogin() async {
    Get.dialog(const LoginDialog());
  }
}
