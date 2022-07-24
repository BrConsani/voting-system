import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system/shared/entity/voting.dart';

const String _endpoint = '54.94.241.52:8080';

class VotingRepository {
  Future<void> createVoting(Voting voting) async {
    final response = await http.post(
      Uri.http(_endpoint, '/votings/v1/votings'),
      body: voting.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    final map = jsonDecode(utf8.decode(response.bodyBytes));

    final createdVoting = Voting.fromMap(Map.from(map['data']));

    final futures = voting.candidates.map((candidate) {
      return http.post(
        Uri.http(
          _endpoint,
          '/votings/v1/votings/${createdVoting.id}/candidates',
        ),
        body: candidate.toJson(),
        headers: {'Content-Type': 'application/json'},
      );
    });

    await Future.wait(futures);
  }

  Future<List<Voting>> getVotings() async {
    final response = await http.get(
      Uri.http(_endpoint, '/votings/v1/votings'),
    );

    final map = jsonDecode(utf8.decode(response.bodyBytes));

    return map['data']
        .map<Voting>((voting) => Voting.fromMap(Map.from(voting)))
        .toList();
  }

  Future<Voting> getVotingById(String id) async {
    final response = await http.get(
      Uri.http(_endpoint, '/votings/v1/votings/$id'),
    );

    final map = jsonDecode(utf8.decode(response.bodyBytes));

    return Voting.fromMap(Map.from(map['data']));
  }
}
