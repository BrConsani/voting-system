import 'dart:convert';

import 'package:voting_system/shared/entity/candidate.dart';

class Voting {
  final String? id;
  final String name;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<Candidate> candidates;

  Voting(
      {this.id,
      required this.name,
      required this.imageUrl,
      required this.startDate,
      required this.endDate,
      required this.candidates});

  Voting copyWith({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    List<Candidate>? candidates,
  }) {
    return Voting(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      candidates: candidates ?? this.candidates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'start_time': startDate.millisecondsSinceEpoch,
      'end_time': endDate.millisecondsSinceEpoch,
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
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
