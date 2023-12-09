// import 'package:chess/core/functions/logic_functions.dart';
// import 'package:flutter/material.dart';
//
// import '../../components/square.dart';
// import '../functions/helper_functions.dart';
//
// class BoardWidget extends StatefulWidget {
//   final String boardPicture;
//   final int selectedRow;
//   final int selectedCol;
//
//   const BoardWidget({
//     super.key,
//     required this.boardPicture,
//     required this.selectedRow,
//     required this.selectedCol
//
//   });
//
//   @override
//   State<BoardWidget> createState() => _BoardWidgetState();
// }
//
// class _BoardWidgetState extends State<BoardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Stack(alignment: FractionalOffset.center,
//             children:[
//               Container(width: 450,height: 450,
//                 child:
//                 Image.asset(widget.boardPicture),
//               ),
//               Container(height: 400,width: 400,
//                 child: GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 8 * 8,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
//                     itemBuilder: (context, index) {
//                       // get the row and col position of this square
//                       int row = index ~/ 8;
//                       int col = index % 8;
//
//                       // check if this square is selected
//                       bool isSelected = selectedRow == row && selectedCol == col;
//
//                       // check  if this square is a valid move
//                       bool isValidMove = false;
//                       for (var position in validMoves) {
//                         // compare row and col
//                         if (position[0] == row && position[1] == col){
//                           isValidMove = true;
//                         }
//                       }
//
//                       return Square(
//                         isWhite: isWhite(index),
//                         piece: board[row][col],
//                         isSelected: isSelected,
//                         isValidMove: isValidMove,
//                         onTap: () => pieceSelected(row, col),
//                       );
//                     }
//                 ),
//               ),
//             ]
//         ),
//       ],
//     );
//   }
// }
