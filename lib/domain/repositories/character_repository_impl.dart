import '../entities/character.dart';
import '../../data/repositories/character_repository.dart';
import '../../data/local/app_database.dart';
import '../../data/models/character_model.dart';
import '../../data/services/character_api_service.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterApiService apiService;
  final AppDatabase appDatabase;

  CharacterRepositoryImpl({
    required this.apiService,
    required this.appDatabase,
  });

  @override
  Future<List<Character>> getCharacters({String? name}) async {
    final characterModels = await apiService.getCharacters(name: name);

    return characterModels
        .map((characterModel) => characterModel.toEntity())
        .toList();
  }

  @override
  Future<Character> getCharacterById(int id) async {
    final characterModel = await apiService.getCharacterById(id);

    return characterModel.toEntity();
  }

  @override
  Future<void> addToFavorites(Character character) async {
    final characterModel = CharacterModel.fromEntity(character);

    await appDatabase.insertFavorite(characterModel);
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    await appDatabase.deleteFavorite(id);
  }

  @override
  Future<bool> isFavorite(int id) async {
    return appDatabase.isFavorite(id);
  }

  @override
  Future<List<Character>> getFavoriteCharacters() async {
    final favorites = await appDatabase.getFavorites();

    return favorites.map((character) => character.toEntity()).toList();
  }
}