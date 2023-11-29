import 'package:chess/core/pages/game_board.dart';
import 'package:flutter/material.dart';

import '../../../constants/icons.dart';

class TwoPlayerMode extends StatelessWidget {
  const TwoPlayerMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Image.asset(AppIcons.mainMenu).color,
      body: GameBoard(),
    );
  }
}
