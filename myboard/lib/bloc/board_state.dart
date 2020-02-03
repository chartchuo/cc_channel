part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  const BoardState();
}

class BoardInitial extends BoardState {
  @override
  List<Object> get props => [];
}

class BoardUpdateState extends BoardState {
  final Board board;

  BoardUpdateState(this.board);

  @override
  List<Object> get props => [board.lastUpdate];
}
