import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.originName,
    required super.locationName,
    required super.imageUrl,
    required super.episodes,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final origin = json['origin'];
    final location = json['location'];
    final episodeList = json['episode'];

    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      type: json['type'] ?? '',
      gender: json['gender'] ?? 'Unknown',
      originName: origin is Map<String, dynamic>
          ? origin['name'] ?? 'Unknown'
          : 'Unknown',
      locationName: location is Map<String, dynamic>
          ? location['name'] ?? 'Unknown'
          : 'Unknown',
      imageUrl: json['image'] ?? '',
      episodes: episodeList is List
          ? episodeList.map((episode) => episode.toString()).toList()
          : [],
    );
  }

  Character toEntity() {
    return this;
  }
}