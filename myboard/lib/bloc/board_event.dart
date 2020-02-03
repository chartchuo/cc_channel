part of 'board_bloc.dart';

abstract class BoardEvent {
  const BoardEvent();
}

class LoadBoardEvent extends BoardEvent {}

class UpdateBoardEvent extends BoardEvent {
  final Board board;

  UpdateBoardEvent(this.board);
}
