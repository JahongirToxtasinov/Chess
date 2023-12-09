// import 'package:chess/components/pawns_changing.dart';
// import 'package:chess/components/piece.dart';
// import 'package:chess/components/square.dart';
// import 'package:chess/constants/colors.dart';
// import 'package:chess/constants/icons.dart';
// import 'package:chess/core/widgets/taken_pieces_widget.dart';
// import 'package:chess/core/widgets/w_scale.dart';
// import 'package:flutter/material.dart';
//
// import '../functions/helper_functions.dart';
// import '../functions/initialize_board.dart';
// import 'logic_functions.dart';
//
// class GameBoard2 extends StatefulWidget {
//   const GameBoard2({super.key});
//
//   @override
//   State<GameBoard2> createState() => _GameBoard2State();
// }
//
// class _GameBoard2State extends State<GameBoard2> {
//
//   @override
//   void initState() {
//     super.initState();
//     board = initializeBoard();
//   }
//
//   // user selected piece
//   void pieceSelected(int row,int col){
//     setState(() {
//       // NO piece has been selected yet, this is the first selection
//       if (selectedPiece == null && board[row][col] != null) {
//         print("opponent piece");
//         if (board[row][col]!.isWhite == isWhiteTurn) {
//           print('correct selected');
//           selectedPiece = board[row][col];
//           selectedRow = row;
//           selectedCol = col;
//         }
//       }
//
//       // There is a piece already selected, but user can selected another one of their pieces
//       else if (board[row][col] != null &&
//           board[row][col]!.isWhite == selectedPiece!.isWhite) {
//         print("other piece selected");
//         selectedPiece = board[row][col];
//         selectedRow = row;
//         selectedCol = col;
//       }
//
//       /* if there is a piece selected and user taps on a square that
//       is a valid move, move there */
//       else if(selectedPiece != null &&
//           validMoves.any((element) => element[0] == row && element[1] == col)){
//
//         movePiece(row, col);
//       }
//
//       // if a piece is selected, calculate it's valid moves
//       validMoves =
//           calculatedRealValidMoves(selectedRow, selectedCol, selectedPiece, true);
//     });
//   }
//
//   // move the piece
//   void movePiece(int newRow, int newCol) {
//
//     if (selectedPiece!.type == ChessPieceType.pawn && (newRow == 0 || newRow == 7)) {
//       // Display a dialog to let the user choose the promotion piece
//       _showPromotionDialog(selectedPiece!.isWhite).then((selectedPromotion) {
//         switch(num){
//           case 1:
//             print(selectedPromotion.runtimeType);
//             board[newRow][newCol] = ChessPiece(
//                 type: ChessPieceType.knight,
//                 isWhite: !isWhiteTurn,
//                 imagePath: !isWhiteTurn ? WhitePiecePath.knight : BlackPiecePath.knight);
//             setState(() {});
//             break;
//           case 2:
//             board[newRow][newCol] = ChessPiece(
//                 type: ChessPieceType.bishop,
//                 isWhite: !isWhiteTurn,
//                 imagePath: !isWhiteTurn ? WhitePiecePath.bishop : BlackPiecePath.bishop);
//             setState(() {});
//             break;
//
//           case 3:
//             board[newRow][newCol] = ChessPiece(
//                 type: ChessPieceType.rook,
//                 isWhite: !isWhiteTurn,
//                 imagePath: !isWhiteTurn ? WhitePiecePath.rook : BlackPiecePath.rook);
//             setState(() {});
//             break;
//           case 4:
//             board[newRow][newCol] = ChessPiece(
//                 type: ChessPieceType.queen,
//                 isWhite: !isWhiteTurn,
//                 imagePath: !isWhiteTurn ? WhitePiecePath.queen : BlackPiecePath.queen);
//             setState(() {});
//             break;
//           default:
//             break;
//         }
//       });
//     }
//
//     // if the new spot as an enemy piece
//     if (board[newRow][newCol] != null) {
//       // add the captured piece to the appropirate list
//       var capturedPiece = board[newRow][newCol];
//       if (capturedPiece!.isWhite) {
//         whitePiecesTaken.add(capturedPiece);
//       } else {
//         blackPiecesTaken.add(capturedPiece);
//       }
//     }
//
//     // check the piece being moved in a king
//     if (selectedPiece!.type == ChessPieceType.king) {
//       // update the appropriate king pas
//       if (selectedPiece!.isWhite) {
//         whiteKingPosition = [newRow, newCol];
//       } else {
//         blackKingPosition = [newRow, newCol];
//       }
//     }
//
//     // move the piece and clear the old spot
//     board[newRow][newCol] = selectedPiece;
//     print("old position ${board[selectedRow][selectedCol]} \n $selectedPiece \n$selectedRow $selectedCol");
//     print("nes position ${board[newRow][newCol]} \n $selectedPiece \n$newRow $newCol");
//     board[selectedRow][selectedCol] = null;
//
//     // see if any kings are under attack
//     if (isKingInCheck(!isWhiteTurn)) {
//       checkStatus = true;
//     } else {
//       checkStatus = false;
//     }
//
//     // clear the selection
//     setState(() {
//       selectedPiece = null;
//       selectedRow = -1;
//       selectedCol = -1;
//       validMoves = [];
//     });
//
//     // check if it's check mate
//     if (isCheckMate(!isWhiteTurn)) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Center(child: Text("CHECK MATE!\n ${!isWhiteTurn ? 'WHITE WIN' : 'BLACK WIN'}")),
//           actions: [
//             // play again button
//             TextButton(
//                 onPressed: resetGame,
//                 child: Text("REVENGE",
//                   style: TextStyle(
//                       color: Colors.blue,fontSize: 14),))
//           ],
//         ),
//
//       );
//     }
//
//     // change turns
//     isWhiteTurn = !isWhiteTurn;
//   }
//
//   // Method to show the promotion dialog
//   Future<ChessPieceType?> _showPromotionDialog(bool isWhite) async {
//     return showDialog<ChessPieceType>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose Promotion Piece'),
//           actions: [
//             WScale(
//               onTap: () {
//                 num = 1;
//                 Navigator.pop(context);
//               },
//               child: ChangePawn(
//                 imagePath: isWhite ? WhitePiecePath.knight : BlackPiecePath.knight,
//                 isWhite: isWhite,
//               ),
//             ),
//             WScale(
//               onTap: () {
//                 num = 2;
//                 Navigator.pop(context);
//               },
//               child: ChangePawn(
//                 imagePath: isWhite ? WhitePiecePath.bishop : BlackPiecePath.bishop,
//                 isWhite: isWhite,
//               ),
//             ),
//             WScale(
//               onTap: () {
//                 num = 3;
//                 Navigator.pop(context);
//               },
//               child: ChangePawn(
//                 imagePath: isWhite ? WhitePiecePath.rook : BlackPiecePath.rook,
//                 isWhite: isWhite,
//               ),
//             ),
//             WScale(
//               onTap: () {
//                 num = 4;
//                 Navigator.pop(context);
//               },
//               child: ChangePawn(
//                 imagePath: isWhite ? WhitePiecePath.queen : BlackPiecePath.queen,
//                 isWhite: isWhite,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // IS IT CHECK MATE?
//   bool isCheckMate(bool isWhiteKing) {
//     // if the king is not in check, then it's not checkmate
//     if (!isKingInCheck(isWhiteKing)) {
//       return false;
//     }
//     // if there is at least one legal move for any of the player's pieces, then it's not checkmate
//     for (int i = 0; i < 8; i++) {
//       for (int j = 0; j < 8; j++) {
//         // skip empty squares and pieces of the other color
//         if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
//           continue;
//         }
//         List<List<int>> pieceValidMoves =
//         calculatedRealValidMoves(i, j, board[i][j], true);
//
//         // if this piece has any valid moves, then it's not checkmate
//         if (pieceValidMoves.isNotEmpty) {
//           return false;
//         }
//       }
//     }
//     // if none of the above conditions are met, then are no legal moves left to make
//     // it's check mate!
//     return true;
//   }
//
//   // RESTART GAME
//   void resetGame() {
//     Navigator.pop(context);
//     board = initializeBoard();
//     checkStatus = false;
//     whitePiecesTaken.clear();
//     blackPiecesTaken.clear();
//     whiteKingPosition = [7,4];
//     blackKingPosition = [0,4];
//     isWhiteTurn = true;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       // crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Game status
//         Text(checkStatus ? "CHECK!" : ""),
//         // WHITE PIECES TAKEN
//         TakenPieces(
//             widgetColor: whiteBoardColor,
//             wItemCount: whitePiecesTaken,
//             colorPiecesTaken: whitePiecesTaken
//         ),
//         SizedBox(height: 10,),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(alignment: FractionalOffset.center,
//                 children:[
//                   Container(width: 450,height: 450,
//                     child:
//                     Image.asset(AppIcons.mainBoard),
//                   ),
//                   Container(height: 400,width: 400,
//                     child: GridView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 8 * 8,
//                         gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
//                         itemBuilder: (context, index) {
//                           // get the row and col position of this square
//                           int row = index ~/ 8;
//                           int col = index % 8;
//
//                           // check if this square is selected
//                           bool isSelected = selectedRow == row && selectedCol == col;
//
//                           // check  if this square is a valid move
//                           bool isValidMove = false;
//                           for (var position in validMoves) {
//                             // compare row and col
//                             if (position[0] == row && position[1] == col){
//                               isValidMove = true;
//                             }
//                           }
//
//                           return Square(
//                             isWhite: isWhite(index),
//                             piece: board[row][col],
//                             isSelected: isSelected,
//                             isValidMove: isValidMove,
//                             onTap: () => pieceSelected(row, col),
//                           );
//                         }
//                     ),
//                   ),
//                 ]
//             ),
//           ],
//         ),
//         SizedBox(height: 10,),
//         // BLACK PIECES TAKEN
//         TakenPieces(
//             widgetColor: whiteBoardColor,
//             wItemCount: blackPiecesTaken,
//             colorPiecesTaken: blackPiecesTaken
//         ),
//       ],
//     );
//   }
// }
