


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

  // the currently selected piece on the chess board
  // if no piece is selected this is null
  ChessPiece? selectedPiece;

  //the row index of the selected piece
  // default value -1 indicated no piece is currently selected
  int selectedRow = -1;

  //the col index of the selected piece
  // default value -1 indicated no piece is currently selected
  int selectedCol = -1;

  // a list of valid moves for the currently selected piece
  // each move is represented as a list with 2 elements: row col
  List<List<int>> validMoves = [];

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
            imagePath: PieceIcons.pawnB
          );
        newBoard[6][i] = ChessPiece(
            type: ChessPieceType.pawn,
            isWhite: true,
            imagePath: PieceIcons.pawnW);
      }
    // Place rooks
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: PieceIcons.rookB
    );
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: PieceIcons.rookB
    );
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: PieceIcons.rookW
    );
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: PieceIcons.rookW
    );
    // Place knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: PieceIcons.knightB
    );
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: PieceIcons.knightB
    );
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: PieceIcons.knightW
    );
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: PieceIcons.knightW
    );
    // Place bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: PieceIcons.bishopB
    );
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: PieceIcons.bishopB
    );
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: PieceIcons.bishopW
    );
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: PieceIcons.bishopW
    );
    // Place queens
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: PieceIcons.queenB
    );
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: PieceIcons.queenW
    );
    // Place kings
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: PieceIcons.kingB
    );
    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: PieceIcons.kingW
    );
    board = newBoard;
  }

  // user selected piece
  void pieceSelected(int row,int col){
    setState(() {
      // selected a piece if there is a piece in that position
      if(board[row][col] != null){
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      // if a piece is selected, calculate it's valid moves
      validMoves = calculatedRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  /// Calculate RAW VALID MOVES
  List<List<int>> calculatedRawValidMoves(int row,int col,ChessPiece? piece){
    List<List<int>> candidateMoves = [];

    // different directions based on their color
    int direction = piece!.isWhite ? -1 : 1;

    switch (piece.type){
      case ChessPieceType.pawn:
        // pawns can move forward if the square is not occupied
        if (isInBoard(row + direction,col) &&
        board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }
        // pawns can move 2 squares forward if they are at their initial position
        if((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
          board[row + 2 * direction][col] == null &&
          board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
            }
        }

        // pawns can kill diagonally
        if (isInBoard(row + direction, col -1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
          break;

      case ChessPieceType.rook:
        // horizontal and vertical directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
        ];

        for(var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow,newCol)){
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol] != piece.isWhite) {
                candidateMoves.add([newRow,newCol]); // kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }

        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.queen:
        break;
      case ChessPieceType.king:
        break;
      default:
    }
    return candidateMoves;
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

          // check if this square is selected
          bool isSelected = selectedRow == row && selectedCol == col;

          // check  if this square is a valid move
          bool isValidMove = false;
          for (var position in validMoves) {
            // compare row and col
            if (position[0] == row && position[1] == col){
              isValidMove = true;
            }
          }

          return Square(
              isWhite: isWhite(index),
              piece: board[row][col],
              isSelected: isSelected,
              isValidMove: isValidMove,
              onTap: () => pieceSelected(row, col),
          );
          }
      ),
    );
  }
}
