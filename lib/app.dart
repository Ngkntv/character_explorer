import 'package:flutter/material.dart';

import 'presentation/screens/character_list_screen.dart';

class CharacterExplorerApp extends StatelessWidget {
  const CharacterExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Character Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CharacterListScreen(),
    );
  }
}
