
import 'package:chess/components/piece.dart';
import 'package:flutter/material.dart';
import '../constants/icons.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final void Function() ? onTap;
  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.isValidMove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Image? squareColor;

    // if selected square is green
    if(isSelected){
      squareColor = Image.asset(AppIcons.boardSelected);

    }else if (isValidMove){
      squareColor = Image.asset(AppIcons.boardSelectedDirect);
    }
    else{
      squareColor = Image.asset(isWhite == true ? AppIcons.boardWhite : AppIcons.boardBlack);

    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: squareColor.color,
        child: Stack(
          children: [
            squareColor,
            // Image.asset( isWhite ? AppIcons.boardWhite : AppIcons.boardBlack),
            Container(width: 180,height: 180,
                child: isWhite ?
                piece != null ? Image.asset(piece!.imagePath) : null
                : piece != null ? Image.asset(piece!.imagePath) : null
            ),
          ],
        ),
        // child: piece != null ? Image.asset(piece!.imagePath) : null,
      ),
    );
  }
}
