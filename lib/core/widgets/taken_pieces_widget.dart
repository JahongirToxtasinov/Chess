import 'package:flutter/material.dart';

import '../../components/dead_piece.dart';
import '../../components/piece.dart';

class TakenPieces extends StatefulWidget {
  final Color widgetColor;
  final List<ChessPiece> wItemCount;
  final List<ChessPiece> colorPiecesTaken;
  const TakenPieces({
    super.key,
    required this.widgetColor,
    required this.wItemCount,
    required this.colorPiecesTaken,
  });

  @override
  State<TakenPieces> createState() => _TakenPiecesState();
}

class _TakenPiecesState extends State<TakenPieces> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 430,height: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: widget.widgetColor,),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.wItemCount.length,
            gridDelegate: const
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 16),
            itemBuilder: (context, index) => DeadPiece(
              imagePath: widget.colorPiecesTaken[index].imagePath,
              isWhite: true,
            ),
          ),
        ),
      ],
    );
  }
}
