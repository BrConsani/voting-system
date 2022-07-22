import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system/shared/entity/voting.dart';

class VotingRepository {
  Future<void> createVoting(Voting voting) async {
    final response = await http.post(
      Uri.https('15.229.68.50:8080', '/votings/v1/votings'),
      body: voting.toJson(),
    );

    final createdVoting = Voting.fromJson(response.body);

    final futures = createdVoting.candidates.map((candidate) {
      return http.post(
        Uri.https(
          '15.229.68.50:8080',
          '/votings/v1/votings/${createdVoting.id}/candidates',
        ),
        body: voting.toMap(),
      );
    });

    await Future.wait(futures);
  }

  Future<List<Voting>> getVotings() async {
    final response = await http.get(
      Uri.http('15.229.68.50:8080', '/votings/v1/votings'),
    );

    final map = jsonDecode(utf8.decode(response.bodyBytes));

    return map['data']
        .map<Voting>((voting) => Voting.fromMap(Map.from(voting)))
        .toList();
  }
}
