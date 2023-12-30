import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:match5/core/data/repository/ilocal_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  final ILocalRepository _localRepository;
  late final Random random;

  GameBloc(
    this._localRepository,
  ) : super(GameState()) {
    random = Random();
    on<ButtonClicked>(_onButtonClicked);
    on<TimeOut>(_onTimeOut);
  }

  FutureOr<void> _onButtonClicked(ButtonClicked event, emit) async {
    int randomNumber = random.nextInt(59);
    int currentSecond = DateTime.now().second;
    int successAttemptCount = _localRepository.getSuccessfulAttemptCount();
    int failedAttemptCount = _localRepository.getFailedAttemptCount();

    if (randomNumber == currentSecond) {
      successAttemptCount += 1;
      await _localRepository.setSuccessfulAttemptCount(successAttemptCount);
    } else {
      failedAttemptCount += 1;
      await _localRepository.setFailedAttemptCount(failedAttemptCount);
    }

    emit(
      state.copyWith(
        randomNumber: randomNumber,
        currentSecond: currentSecond,
        attempts: failedAttemptCount,
        score: "$successAttemptCount / ${successAttemptCount + failedAttemptCount}",
        isTimeOut: false,
      ),
    );
  }

  FutureOr<void> _onTimeOut(TimeOut event, emit) async {
    int failedAttemptCount = _localRepository.getFailedAttemptCount() + 1;
    await _localRepository.setFailedAttemptCount(failedAttemptCount);
    emit(
      state.copyWith(
        isTimeOut: true,
        attempts: failedAttemptCount,
      ),
    );
  }
}
