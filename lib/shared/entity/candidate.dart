import 'dart:convert';

class Candidate {
  final String? id;
  final String name;
  final String imageUrl;
  final int votes;

  Candidate({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.votes,
  });

  Candidate copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? votes,
  }) {
    return Candidate(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      votes: votes ?? this.votes,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image_url': imageUrl};
  }

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
      id: map['id'],
      name: map['name'],
      imageUrl: map['image_url'] ?? '',
      votes: map['votes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Candidate.fromJson(String source) =>
      Candidate.fromMap(json.decode(source));

  @override
  String toString() => 'Candidate(id: $id, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Candidate &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.votes == votes;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ imageUrl.hashCode ^ votes.hashCode;
  }
}
