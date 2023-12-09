// // A w-dimensional list the chessboard
// // with each position possibly containing a chess piece
// import '../../components/piece.dart';
// import 'helper_functions.dart';
//
// late List<List<ChessPiece?>> board; // position of board coordinate it contains piece or null
//
//
// // the currently selected piece on the chess board
// // if no piece is selected this is null
// ChessPiece? selectedPiece;
//
// //the row index of the selected piece
// // default value -1 indicated no piece is currently selected
// int selectedRow = -1;
//
// //the col index of the selected piece
// // default value -1 indicated no piece is currently selected
// int selectedCol = -1;
//
// // pawn change
// int num = -1;
//
// // a list of valid moves for the currently selected piece
// // each move is represented as a list with 2 elements: row col
// List<List<int>> validMoves = [];
//
// // a list of white pieces that have been taken by the black player
// List<ChessPiece> whitePiecesTaken = [];
//
// // a list of black pieces that have been taken by the white player
// List<ChessPiece> blackPiecesTaken = [];
//
// // A bool to indicate whose turn it is
// bool isWhiteTurn = true;
//
// // initial position of kings (keep track of this to make later to see if king is in check)
// List<int> whiteKingPosition = [7,4];
// List<int> blackKingPosition = [0,4];
// bool checkStatus = false;
//
// void pieceSelected(int row,int col){
//
//     // NO piece has been selected yet, this is the first selection
//     if (selectedPiece == null && board[row][col] != null) {
//       if (board[row][col]!.isWhite == isWhiteTurn) {
//         print('correct selected');
//         selectedPiece = board[row][col];
//         selectedRow = row;
//         selectedCol = col;
//       }
//     }
//
//     // There is a piece already selected, but user can selected another one of their pieces
//     else if (board[row][col] != null &&
//         board[row][col]!.isWhite == selectedPiece!.isWhite) {
//       print("other piece selected");
//       selectedPiece = board[row][col];
//       selectedRow = row;
//       selectedCol = col;
//     }
//
//     /* if there is a piece selected and user taps on a square that
//       is a valid move, move there */
//     else if(selectedPiece != null &&
//         validMoves.any((element) => element[0] == row && element[1] == col)){
//
//       movePiece(row, col);
//     }
//
//     // if a piece is selected, calculate it's valid moves
//     validMoves =
//         calculatedRealValidMoves(selectedRow, selectedCol, selectedPiece, true);
//
// }
//
// void movePiece(int newRow, int newCol) {
//
//   if (selectedPiece!.type == ChessPieceType.pawn && (newRow == 0 || newRow == 7)) {
//     // Display a dialog to let the user choose the promotion piece
//     _showPromotionDialog(selectedPiece!.isWhite).then((selectedPromotion) {
//       switch(num){
//         case 1:
//           print(selectedPromotion.runtimeType);
//           board[newRow][newCol] = ChessPiece(
//               type: ChessPieceType.knight,
//               isWhite: !isWhiteTurn,
//               imagePath: !isWhiteTurn ? WhitePiecePath.knight : BlackPiecePath.knight);
//           setState(() {});
//           break;
//         case 2:
//           board[newRow][newCol] = ChessPiece(
//               type: ChessPieceType.bishop,
//               isWhite: !isWhiteTurn,
//               imagePath: !isWhiteTurn ? WhitePiecePath.bishop : BlackPiecePath.bishop);
//           setState(() {});
//           break;
//
//         case 3:
//           board[newRow][newCol] = ChessPiece(
//               type: ChessPieceType.rook,
//               isWhite: !isWhiteTurn,
//               imagePath: !isWhiteTurn ? WhitePiecePath.rook : BlackPiecePath.rook);
//           setState(() {});
//           break;
//         case 4:
//           board[newRow][newCol] = ChessPiece(
//               type: ChessPieceType.queen,
//               isWhite: !isWhiteTurn,
//               imagePath: !isWhiteTurn ? WhitePiecePath.queen : BlackPiecePath.queen);
//           setState(() {});
//           break;
//         default:
//           break;
//       }
//     });
//   }
//
//   // if the new spot as an enemy piece
//   if (board[newRow][newCol] != null) {
//     // add the captured piece to the appropirate list
//     var capturedPiece = board[newRow][newCol];
//     if (capturedPiece!.isWhite) {
//       whitePiecesTaken.add(capturedPiece);
//     } else {
//       blackPiecesTaken.add(capturedPiece);
//     }
//   }
//
//   // check the piece being moved in a king
//   if (selectedPiece!.type == ChessPieceType.king) {
//     // update the appropriate king pas
//     if (selectedPiece!.isWhite) {
//       whiteKingPosition = [newRow, newCol];
//     } else {
//       blackKingPosition = [newRow, newCol];
//     }
//   }
//
//   // move the piece and clear the old spot
//   board[newRow][newCol] = selectedPiece;
//   print("old position ${board[selectedRow][selectedCol]} \n $selectedPiece \n$selectedRow $selectedCol");
//   print("nes position ${board[newRow][newCol]} \n $selectedPiece \n$newRow $newCol");
//   board[selectedRow][selectedCol] = null;
//
//   // see if any kings are under attack
//   if (isKingInCheck(!isWhiteTurn)) {
//     checkStatus = true;
//   } else {
//     checkStatus = false;
//   }
//
//   // clear the selection
//   setState(() {
//     selectedPiece = null;
//     selectedRow = -1;
//     selectedCol = -1;
//     validMoves = [];
//   });
//
//   // check if it's check mate
//   if (isCheckMate(!isWhiteTurn)) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Center(child: Text("CHECK MATE!\n ${!isWhiteTurn ? 'WHITE WIN' : 'BLACK WIN'}")),
//         actions: [
//           // play again button
//           TextButton(
//               onPressed: resetGame,
//               child: Text("REVENGE",
//                 style: TextStyle(
//                     color: Colors.blue,fontSize: 14),))
//         ],
//       ),
//
//     );
//   }
//
//   // change turns
//   isWhiteTurn = !isWhiteTurn;
// }
//
//
// /// Calculate RAW VALID MOVES
// List<List<int>> calculatedRawValidMoves(int row,int col,ChessPiece? piece){
//   List<List<int>> candidateMoves = [];
//
//   if (piece == null) {
//     return [];
//   }
//
//   // different directions based on their color
//   int direction = piece.isWhite ? -1 : 1;
//
//   switch (piece.type){
//     case ChessPieceType.pawn:
//     // pawns can move forward if the square is not occupied
//       if (isInBoard(row + direction,col) &&
//           board[row + direction][col] == null) {
//         candidateMoves.add([row + direction, col]);
//       }
//       // pawns can move 2 squares forward if they are at their initial position
//       if((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
//         if (isInBoard(row + 2 * direction, col) &&
//             board[row + 2 * direction][col] == null &&
//             board[row + direction][col] == null) {
//           candidateMoves.add([row + 2 * direction, col]);
//         }
//       }
//
//       // pawns can kill diagonally
//       if (isInBoard(row + direction, col -1) &&
//           board[row + direction][col - 1] != null &&
//           board[row + direction][col - 1]!.isWhite != piece.isWhite) {
//         candidateMoves.add([row + direction, col - 1]);
//       }
//       if (isInBoard(row + direction, col + 1) &&
//           board[row + direction][col + 1] != null &&
//           board[row + direction][col + 1]!.isWhite != piece.isWhite) {
//         candidateMoves.add([row + direction, col + 1]);
//       }
//       break;
//
//     case ChessPieceType.rook:
//     // horizontal and vertical directions
//       var directions = [
//         [-1, 0], // up
//         [1, 0], // down
//         [0, -1], // left
//         [0, 1], // right
//       ];
//
//       for(var direction in directions) {
//         var i = 1;
//         while (true) {
//           var newRow = row + i * direction[0];
//           var newCol = col + i * direction[1];
//           if (!isInBoard(newRow,newCol)){
//             break;
//           }
//           if (board[newRow][newCol] != null) {
//             if (board[newRow][newCol]!.isWhite != piece.isWhite) {
//               candidateMoves.add([newRow,newCol]); // kill
//             }
//             break; // blocked
//           }
//           candidateMoves.add([newRow, newCol]);
//           i++;
//         }
//       }
//       break;
//
//     case ChessPieceType.knight:
//     // all eight possible L shapes the knight can move
//       var knightMoves = [
//         [-2, -1], // up 2 left 1
//         [-2, 1], // up 2 right 1
//         [-1, -2], // up 1 left 2
//         [-1, 2], // up 1 right 2
//         [1, -2], // down 1 left 2
//         [1, 2], // down 1 right 2
//         [2, -1], // down 2 left 1
//         [2, 1], // down 2 right 1
//       ];
//
//       for(var move in knightMoves){
//         var newRow = row + move[0];
//         var newCol = col + move[1];
//         if (!isInBoard(newRow, newCol)) {
//           continue;
//         }
//         if (board[newRow][newCol] != null){
//           if (board[newRow][newCol]!.isWhite != piece.isWhite) {
//             candidateMoves.add([newRow, newCol]); // kill
//           }
//           continue; // blocked
//         }
//         candidateMoves.add([newRow, newCol]);
//       }
//       break;
//
//     case ChessPieceType.bishop:
//     // diagonal direction
//       var directions = [
//         [-1, -1], // up left
//         [-1, 1], // up right
//         [1, -1], // down left
//         [1, 1], // down right
//       ];
//
//       for (var direction in directions) {
//         var i = 1;
//         while (true) {
//           var newRow = row + i * direction[0];
//           var newCol = col + i * direction[1];
//           if (!isInBoard(newRow,newCol)) {
//             break;
//           }
//           if (board[newRow][newCol] != null) {
//             if (board[newRow][newCol]!.isWhite != piece.isWhite) {
//               candidateMoves.add([newRow, newCol]); // kill
//             }
//             break;
//           }
//           candidateMoves.add([newRow,newCol]);
//           i++;
//         }
//       }
//       break;
//
//     case ChessPieceType.queen:
//     // all eight directions: up, down, left , right, and 4 diagonals
//       var directions = [
//         [-1, 0], // up
//         [1, 0], // down
//         [0, -1], // left
//         [0, 1], // right
//         [-1, -1], // up left
//         [-1, 1], // up right
//         [1, -1], // down left
//         [1, 1], // down right
//       ];
//
//       for (var direction in directions) {
//         var i = 1;
//         while (true) {
//           var newRow = row + i * direction[0];
//           var newCol = col + i * direction[1];
//           if (!isInBoard(newRow, newCol)) {
//             break;
//           }
//           if (board[newRow][newCol] != null) {
//             if (board[newRow][newCol]!.isWhite != piece.isWhite) {
//               candidateMoves.add([newRow, newCol]); // kill
//             }
//             break;
//           }
//           candidateMoves.add([newRow,newCol]);
//           i++;
//         }
//       }
//       break;
//
//     case ChessPieceType.king:
//     // all eight directions
//       var directions = [
//         [-1, 0], // up
//         [1, 0], // down
//         [0, -1], // left
//         [0, 1], // right
//         [-1, -1], // up left
//         [-1, 1], // up right
//         [1, -1], // down left
//         [1, 1], // down right
//       ];
//
//       for (var direction in directions) {
//         var newRow = row + direction[0];
//         var newCol = col + direction[1];
//         if (!isInBoard(newRow, newCol)) {
//           continue;
//         }
//         if (board[newRow][newCol] != null) {
//           if (board[newRow][newCol]!.isWhite != piece.isWhite) {
//             candidateMoves.add([newRow, newCol]); // kill
//           }
//           continue;
//         }
//         candidateMoves.add([newRow,newCol]);
//       }
//       break;
//     default:
//   }
//   return candidateMoves;
// }
//
// /// CALCULATE REAL VALID MOVE
// List<List<int>> calculatedRealValidMoves (int row, int col, ChessPiece? piece, bool checkSimulation) {
//   List<List<int>> realValidMoves = [];
//   List<List<int>> candidateMoves = calculatedRawValidMoves(row, col, piece);
//
//   // after generating all candidate moves, filter out any that would result in a check
//   if (checkSimulation) {
//     for (var move in candidateMoves) {
//       int endRow = move[0];
//       int endCol = move[1];
//
//       // this will simulate the future move to see if it's safe
//       if (simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
//         realValidMoves.add(move);
//       }
//     }
//   } else {
//     realValidMoves = candidateMoves;
//   }
//   return realValidMoves;
// }
//
//
// // SIMULATE A FUTURE MOVE TO SEE IF IT'S SAFE PUT YOUR OWN UNDER ATTACK!
// bool simulatedMoveIsSafe(
//     ChessPiece piece, int startRow, int startCol, int endRow, int endCol){
//   // save the current board state
//   ChessPiece? originalDestinationPiece = board[endRow][endCol];
//
//   // if the piece is the king, it's current position and update to the new one
//   List<int>? originalKingPosition;
//   if (piece.type == ChessPieceType.king) {
//     originalKingPosition =
//     piece.isWhite ? whiteKingPosition : blackKingPosition;
//
//     // update the king position
//     if (piece.isWhite) {
//       whiteKingPosition = [endRow, endCol];
//     } else {
//       blackKingPosition = [endRow, endCol];
//     }
//   }
//   // simulate the move
//   board[endRow][endCol] = piece;
//   board[startRow][startCol] = null;
//
//   // check if our own king is under attack
//   bool kingInCheck = isKingInCheck(piece.isWhite);
//
//   // restore board to original state
//   board[startRow][startCol] = piece;
//   board[endRow][endCol] = originalDestinationPiece;
//
//   // if the piece as the king, restore it original position
//   if (piece.type == ChessPieceType.king) {
//     if (piece.isWhite) {
//       whiteKingPosition = originalKingPosition!;
//     } else {
//       blackKingPosition = originalKingPosition!;
//     }
//   }
//
//   // if king is in check = true, means it's not a safe move = false
//   return !kingInCheck;
// }
//
// // IS KING IN CHECK
// bool isKingInCheck(bool isWhiteKing){
//   // get the position of the king
//   List<int> kingPosition =
//   isWhiteKing ? whiteKingPosition : blackKingPosition;
//
//   // check if any enemy piece can attack the king
//   for (int i = 0; i < 8; i++) {
//     for (int j = 0; j < 8; j++) {
//       // skip empty squares and pieces of the same color as the king
//       if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing) {
//         continue;
//       }
//
//       List<List<int>> pieceValidMoves =
//       calculatedRealValidMoves(i, j, board[i][j], false);
//
//       // check if the king's position is in this piece's valid moves
//       if (pieceValidMoves.any((move) =>
//       move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
//         return true;
//       }
//     }
//   }
//   return false;
// }
//
//
