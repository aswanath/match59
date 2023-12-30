import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<ButtonClicked>(_onButtonClicked);
  }

  FutureOr<void> _onButtonClicked(ButtonClicked event, emit) {}
}
