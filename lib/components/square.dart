
import 'package:chess/components/piece.dart';
import 'package:flutter/material.dart';
import '../constants/icons.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Image.asset( isWhite ? AppIcons.boardWhite : AppIcons.boardBlack).color,
      child: Stack(
        children: [
          Image.asset( isWhite ? AppIcons.boardWhite : AppIcons.boardBlack),
          Container(width: 180,height: 180,
              child: isWhite ?
              piece != null ? Image.asset(piece!.imagePath) : null
              : piece != null ? Image.asset(piece!.imagePath) : null
          ),
        ],
      ),
      // child: piece != null ? Image.asset(piece!.imagePath) : null,
    );
  }
}
