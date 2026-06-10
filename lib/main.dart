import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/local/app_database.dart';
import 'data/services/character_api_service.dart';
import 'domain/repositories/character_repository_impl.dart';
import 'presentation/viewmodels/character_list_view_model.dart';

void main() {
  final repository = CharacterRepositoryImpl(
    apiService: CharacterApiService(),
    appDatabase: AppDatabase(),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          CharacterListViewModel(repository: repository)..loadCharacters(),
      child: const CharacterExplorerApp(),
    ),
  );
}
