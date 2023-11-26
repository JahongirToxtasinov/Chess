
import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/constants/icons.dart';
import 'package:flutter/material.dart';

import '../functions/helper_functions.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  // A w-dimensional list the chessboard
  // with each position possibly containing a chess piece
  late List<List<ChessPiece?>> board;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  //INITIALIZE BOARD
  void _initializeBoard(){
    //initialize the board nulls, meaning no pieces in those position
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    // Place pawns
      for(int i = 0; i < 8; i++){
        newBoard[1][i] = ChessPiece(
            type: ChessPieceType.pawn,
            isWhite: false,
            imagePath: PieceIcons.pawnW
          );
        newBoard[6][i] = ChessPiece(
            type: ChessPieceType.pawn,
            isWhite: true,
            imagePath: PieceIcons.pawnB);
      }
    // Place rooks

    // Place knights

    // Place bishops

    // Place queens

    // Place kings

    board = newBoard;
  }

  //create a piece
  // ChessPiece myPawn = ChessPiece(
  //     type: ChessPieceType.pawn,
  //     isWhite: true,
  //     imagePath: isWhite == true ? PieceIcons.pawnW : PieceIcons.pawnB
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8 * 8,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (context, index) {
          // get the row and col position of this square
          int row = index ~/ 8;
          int col = index % 8;

          return Square(
              isWhite: isWhite(index),
              piece: board[row][col],
          );
          }
      ),
    );
  }
}
