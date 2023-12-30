part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class ButtonClicked extends GameEvent {}

class TimeOut extends GameEvent {}
