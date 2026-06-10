import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/states/screen_state.dart';
import '../viewmodels/character_list_view_model.dart';
import '../widgets/character_card.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Explorer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск персонажа',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (query) =>
                  context.read<CharacterListViewModel>().searchCharacters(query),
            ),
          ),
          Expanded(
            child: Consumer<CharacterListViewModel>(
              builder: (context, viewModel, child) {
                switch (viewModel.state) {
                  case ScreenState.initial:
                  case ScreenState.loading:
                    return const LoadingView();
                  case ScreenState.error:
                    return ErrorView(
                      message: viewModel.errorMessage ?? 'Произошла ошибка',
                      onRetry: viewModel.retry,
                    );
                  case ScreenState.empty:
                    return const EmptyView();
                  case ScreenState.success:
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: viewModel.characters.length,
                      itemBuilder: (context, index) {
                        return CharacterCard(
                          character: viewModel.characters[index],
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
