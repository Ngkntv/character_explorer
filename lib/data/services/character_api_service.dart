import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/errors/app_exception.dart';
import '../models/character_model.dart';

class CharacterApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  final http.Client _client;

  CharacterApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<CharacterModel>> getCharacters({String? name}) async {
    final uri = Uri.parse('$_baseUrl/character').replace(
      queryParameters: {
        if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
      },
    );

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        final List<dynamic> results = jsonBody['results'] ?? [];

        return results
            .map((item) => CharacterModel.fromJson(item))
            .toList();
      }

      if (response.statusCode == 404) {
        return [];
      }

      throw AppException('Ошибка сервера: ${response.statusCode}');
    } catch (error) {
      if (error is AppException) {
        rethrow;
      }

      throw AppException('Не удалось загрузить список персонажей');
    }
  }

  Future<CharacterModel> getCharacterById(int id) async {
    final uri = Uri.parse('$_baseUrl/character/$id');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        return CharacterModel.fromJson(jsonBody);
      }

      if (response.statusCode == 404) {
        throw AppException('Персонаж не найден');
      }

      throw AppException('Ошибка сервера: ${response.statusCode}');
    } catch (error) {
      if (error is AppException) {
        rethrow;
      }

      throw AppException('Не удалось загрузить данные персонажа');
    }
  }
}