import 'package:flutter/foundation.dart';

import '../../../core/states/screen_state.dart';
import '../../../domain/entities/character.dart';
import '../../../data/repositories/character_repository.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository repository;

  CharacterListViewModel({
    required this.repository,
  });

  ScreenState state = ScreenState.initial;

  List<Character> characters = [];

  String? errorMessage;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  bool get isLoading => state == ScreenState.loading;

  bool get hasError => state == ScreenState.error;

  bool get isEmpty => state == ScreenState.empty;

  Future<void> loadCharacters() async {
    _searchQuery = '';
    await _fetchCharacters();
  }

  Future<void> searchCharacters(String query) async {
    _searchQuery = query.trim();

    if (_searchQuery.isEmpty) {
      await loadCharacters();
      return;
    }

    await _fetchCharacters(name: _searchQuery);
  }

  Future<void> retry() async {
    if (_searchQuery.isEmpty) {
      await _fetchCharacters();
    } else {
      await _fetchCharacters(name: _searchQuery);
    }
  }

  Future<void> _fetchCharacters({String? name}) async {
    state = ScreenState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await repository.getCharacters(name: name);

      characters = result;

      if (characters.isEmpty) {
        state = ScreenState.empty;
      } else {
        state = ScreenState.success;
      }
    } catch (error) {
      characters = [];
      state = ScreenState.error;
      errorMessage = error.toString();
    }

    notifyListeners();
  }
}