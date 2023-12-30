import 'package:flutter/material.dart';
import 'package:match5/src/game/presentation/screens/game_screen.dart';

class Match5App extends StatelessWidget {
  const Match5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Match5",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}
