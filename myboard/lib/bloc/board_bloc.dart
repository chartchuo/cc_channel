import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  Board board;

  @override
  BoardState get initialState => BoardInitial();

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    if (event is LoadBoardEvent) {
      yield BoardInitial();
    } else if (event is UpdateBoardEvent) {
      board = event.board;
      yield BoardUpdateState(board);
    }
  }
}

var boardBloc = BoardBloc();
