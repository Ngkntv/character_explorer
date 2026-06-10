import '../../domain/entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({String? name});

  Future<Character> getCharacterById(int id);

  Future<void> addToFavorites(Character character);

  Future<void> removeFromFavorites(int id);

  Future<bool> isFavorite(int id);

  Future<List<Character>> getFavoriteCharacters();
}