import 'package:chess/core/pages/game_board.dart';
import 'package:flutter/material.dart';

class TwoPlayerMode extends StatelessWidget {
  const TwoPlayerMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GameBoard(),
    );
  }
}
