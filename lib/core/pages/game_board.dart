
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
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: PieceIcons.rookW
    );
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: PieceIcons.rookW
    );
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: PieceIcons.rookB
    );
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: PieceIcons.rookB
    );
    // Place knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: PieceIcons.knightW
    );
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: PieceIcons.knightW
    );
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: PieceIcons.knightB
    );
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: PieceIcons.knightB
    );
    // Place bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: PieceIcons.bishopW
    );
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: PieceIcons.bishopW
    );
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: PieceIcons.bishopB
    );
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: PieceIcons.bishopB
    );
    // Place queens
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: PieceIcons.queenW
    );
    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: PieceIcons.queenB
    );
    // Place kings
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: PieceIcons.kingW
    );
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: PieceIcons.kingB
    );
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
