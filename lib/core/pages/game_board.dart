


import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/constants/colors.dart';
import 'package:chess/constants/icons.dart';
import 'package:flutter/material.dart';

import '../../components/dead_piece.dart';
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

  // a list of white pieces that have been taken by the black player
  List<ChessPiece> whitePiecesTaken = [];

  // a list of black pieces that have been taken by the white player
  List<ChessPiece> blackPiecesTaken = [];

  // A bool to indicate whose turn it is
  bool isWhiteTurn = true;

  // initial position of kings (keep track of this to make later to see if king is in check)
  List<int> whiteKingPosition = [7,4];
  List<int> blackKingPosition = [0,4];
  bool checkStatus = false;

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
     // NO piece has been selected yet, this is the first selection
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.isWhite == isWhiteTurn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      }

      // There is a piece already selected, but user can selected another one of their pieces
      else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      /* if there is a piece selected and user taps on a square that
      is a valid move, move there */
      else if(selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)){
        movePiece(row, col);
      }

      // if a piece is selected, calculate it's valid moves
      validMoves = calculatedRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  /// Calculate RAW VALID MOVES
  List<List<int>> calculatedRawValidMoves(int row,int col,ChessPiece? piece){
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    // different directions based on their color
    int direction = piece.isWhite ? -1 : 1;

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
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
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
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
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
        // all eight possible L shapes the knight can move
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for(var move in knightMoves){
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null){
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // kill
            }
            continue; // blocked
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;

      case ChessPieceType.bishop:
        // diagonal direction
        var directions = [
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow,newCol)) {
              break;
            }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // kill
            }
            break;
          }
            candidateMoves.add([newRow,newCol]);
            i++;
          }
        }
        break;

      case ChessPieceType.queen:
        // all eight directions: up, down, left , right, and 4 diagonals
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // kill
              }
              break;
            }
            candidateMoves.add([newRow,newCol]);
            i++;
          }
        }
        break;

      case ChessPieceType.king:
      // all eight directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
            var newRow = row + direction[0];
            var newCol = col + direction[1];
            if (!isInBoard(newRow, newCol)) {
              continue;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // kill
              }
              continue;
            }
            candidateMoves.add([newRow,newCol]);
        }
        break;
      default:
    }
    return candidateMoves;
  }

  // move the piece
  void movePiece(int newRow, int newCol) {
    // if the new spot as an enemy piece
    if (board[newRow][newCol] != null) {
      // add the captured piece to the appropirate list
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }
    }

    // move the piece and clear the old spot
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // see if any kings are under attack
    if (isKingInCheck(!isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }

    // clear the selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

    // change turns
    isWhiteTurn = !isWhiteTurn;
  }

  // IS KING IN CHECK
  bool isKingInCheck(bool isWhiteKing){
    // get the position of the king
    List<int> kingPosition =
        isWhiteKing ? whiteKingPosition : blackKingPosition;

    // check if any enemy piece can attack the king
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // skip empty squares and pieces of the same color as the king
        if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves =
            calculatedRawValidMoves(i, j, board[i][j]);

        // check if the king's position is in this piece's valid moves
        if (pieceValidMoves.any((move) =>
        move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // WHITE PIECES TAKEN
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 430,height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: whiteBoardColor,),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: whitePiecesTaken.length,
                    gridDelegate: const
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 16),
                itemBuilder: (context, index) => DeadPiece(
                  imagePath: whitePiecesTaken[index].imagePath,
                  isWhite: true,
                ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),

          // Game status
          Text(checkStatus ? "CHECK!" : ""),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(alignment: FractionalOffset.center,
                children:[
                  Container(width: 450,height: 450,
                    child:
                    Image.asset(AppIcons.mainBoard),
                  ),
                  Container(height: 400,width: 400,
                  child: GridView.builder(
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
                ),
                ]
              ),
            ],
          ),
          SizedBox(height: 10,),
          // BLACK PIECES TAKEN
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 430,height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: whiteBoardColor,),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: blackPiecesTaken.length,
                  gridDelegate: const
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 16),
                  itemBuilder: (context, index) => DeadPiece(
                    imagePath: blackPiecesTaken[index].imagePath,
                    isWhite: true,
                  ),
                ),
              ),
            ],
          ),
        ],

    );
  }
}
