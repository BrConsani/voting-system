import 'package:flutter/material.dart';
import 'package:voting_system/pages/vote_page.dart';
import 'package:voting_system/utils/custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voting System',
      theme: ThemeData(primaryColor: CustomColors.blue),
      home: const VotePage(),
    );
  }
}
