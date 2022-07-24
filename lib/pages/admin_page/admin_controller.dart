import 'package:get/get.dart';
import 'package:voting_system/shared/entity/voting.dart';
import 'package:voting_system/shared/repositories/voting_repository.dart';

class AdminController extends GetxController {
  final repository = VotingRepository();
  final votings = <Voting>[].obs;

  @override
  void onReady() {
    getVotings();
    super.onReady();
  }

  Future<void> createVoting(Voting voting) async {
    await repository.createVoting(voting);
    getVotings();
  }

  Future<void> deleteVoting(Voting voting) async {
    if (voting.id == null) return;
    await repository.deleteVoting(voting.id!);
    getVotings();
  }

  Future<void> getVotings() async {
    votings.clear();
    votings.addAll(await repository.getVotings());
  }
}
