import 'package:get/get.dart';
import 'package:voting_system/shared/entity/voting.dart';
import 'package:voting_system/shared/repositories/voting_repository.dart';

class ListController extends GetxController {
  final repository = VotingRepository();
  final votings = <Voting>[].obs;

  @override
  void onReady() {
    getVotings();
    super.onReady();
  }

  Future<void> getVotings() async {
    votings.clear();
    votings.addAll(await repository.getVotings());
  }
}
