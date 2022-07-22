class Candidate {
  final String? id;
  final String name;
  final String imageUrl;

  Candidate({this.id, required this.name, required this.imageUrl});

  Candidate copyWith({String? id, String? name, String? imageUrl}) {
    return Candidate(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
      id: map['id'],
      name: map['name'],
      imageUrl: map['image_url'],
    );
  }

  @override
  String toString() => 'Candidate(id: $id, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Candidate &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
