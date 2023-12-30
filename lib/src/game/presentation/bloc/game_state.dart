part of 'game_bloc.dart';

class GameState {
  final int currentSecond;
  final int randomNumber;
  final int attempts;
  final bool isTimeOut;
  final String score;

  GameState({
    this.currentSecond = -1,
    this.randomNumber = -1,
    this.attempts = -1,
    this.isTimeOut = false,
    this.score = "",
  });

  GameState copyWith({
    int? currentSecond,
    int? randomNumber,
    int? attempts,
    bool? isTimeOut,
    String? score,
  }) =>
      GameState(
        currentSecond: currentSecond ?? this.currentSecond,
        randomNumber: randomNumber ?? this.randomNumber,
        attempts: attempts ?? this.attempts,
        isTimeOut: isTimeOut ?? this.isTimeOut,
        score: score ?? this.score,
      );
}
