import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:voting_system/shared/entity/candidate.dart';

class Voting {
  final String? id;
  final String name;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<Candidate> candidates;
  final bool open;
  final int totalVotes;

  Voting({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.candidates,
    required this.open,
    required this.totalVotes,
  });

  Voting copyWith({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    List<Candidate>? candidates,
    bool? open,
    int? totalVotes,
  }) {
    return Voting(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      candidates: candidates ?? this.candidates,
      open: open ?? this.open,
      totalVotes: totalVotes ?? this.totalVotes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'start_time': startDate.toIso8601String(),
      'end_time': endDate.toIso8601String(),
    };
  }

  factory Voting.fromMap(Map<String, dynamic> map) {
    return Voting(
      id: map['id'],
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
      startDate: DateTime.parse(map['start_time']),
      endDate: DateTime.parse(map['end_time']),
      candidates: map['candidates']
          .map<Candidate>((candidate) => Candidate.fromMap(Map.from(candidate)))
          .toList(),
      open: map['open'] ?? false,
      totalVotes: map['total_votes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Voting.fromJson(String source) => Voting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Voting(id: $id, name: $name, imageUrl: $imageUrl, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Voting &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        listEquals(other.candidates, candidates) &&
        other.open == open &&
        other.totalVotes == totalVotes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        candidates.hashCode ^
        open.hashCode ^
        totalVotes.hashCode;
  }
}
