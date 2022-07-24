import 'package:get/get.dart';
import 'package:voting_system/shared/entity/candidate.dart';
import 'package:voting_system/shared/repositories/voting_repository.dart';

class VoteController extends GetxController {
  final repository = VotingRepository();
  final candidates = <Candidate>[].obs;
  final votingName = ''.obs;

  VoteController(String votingId) {
    getVoting(votingId);
  }

  Future<void> getVoting(String votingId) async {
    final voting = await repository.getVotingById(votingId);
    votingName.value = voting.name;
    candidates.clear();
    candidates.addAll(voting.candidates);
  }

  Future<void> computeVote() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}