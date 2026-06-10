// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:character_explorer/app.dart';
import 'package:character_explorer/data/repositories/character_repository.dart';
import 'package:character_explorer/domain/entities/character.dart';
import 'package:character_explorer/presentation/viewmodels/character_list_view_model.dart';

class FakeCharacterRepository implements CharacterRepository {
  @override
  Future<List<Character>> getCharacters({String? name}) async => [];

  @override
  Future<Character> getCharacterById(int id) async =>
      throw UnimplementedError();

  @override
  Future<void> addToFavorites(Character character) async {}

  @override
  Future<void> removeFromFavorites(int id) async {}

  @override
  Future<bool> isFavorite(int id) async => false;

  @override
  Future<List<Character>> getFavoriteCharacters() async => [];
}

void main() {
  testWidgets('App builds and shows character list screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            CharacterListViewModel(repository: FakeCharacterRepository()),
        child: const CharacterExplorerApp(),
      ),
    );

    expect(find.text('Character Explorer'), findsOneWidget);
  });
}
