import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:voting_system/pages/admin_page/admin_page.dart';
import 'package:voting_system/pages/list_page/list_page.dart';
import 'package:voting_system/pages/vote_page/vote_page.dart';
import 'package:voting_system/shared/utils/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voting System',
      theme: ThemeData(primaryColor: CustomColors.blue),
      initialRoute: '/votes',
      getPages: [
        GetPage(name: '/votes', page: () => ListPage()),
        GetPage(
          name: '/votes/:id',
          page: () => VotePage(votingId: Get.parameters['id']!),
        ),
        GetPage(name: '/admin', page: () => AdminPage()),
      ],
      localizationsDelegates: const [...GlobalMaterialLocalizations.delegates],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
