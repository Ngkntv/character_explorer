import 'dart:convert';

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

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    final episodesJson = map['episodes'] as String? ?? '[]';

    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? 'Unknown',
      status: map['status'] as String? ?? 'Unknown',
      species: map['species'] as String? ?? 'Unknown',
      type: map['type'] as String? ?? '',
      gender: map['gender'] as String? ?? 'Unknown',
      originName: map['originName'] as String? ?? 'Unknown',
      locationName: map['locationName'] as String? ?? 'Unknown',
      imageUrl: map['imageUrl'] as String? ?? '',
      episodes: List<String>.from(jsonDecode(episodesJson)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'originName': originName,
      'locationName': locationName,
      'imageUrl': imageUrl,
      'episodes': jsonEncode(episodes),
    };
  }

  Character toEntity() {
    return this;
  }

  factory CharacterModel.fromEntity(Character character) {
    return CharacterModel(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      originName: character.originName,
      locationName: character.locationName,
      imageUrl: character.imageUrl,
      episodes: character.episodes,
    );
  }
}