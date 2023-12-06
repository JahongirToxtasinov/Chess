import 'package:flutter/material.dart';

class ChangePawn extends StatelessWidget {
  final String imagePath;
  final bool isWhite;
  const ChangePawn({
    super.key,
    required this.imagePath,
    required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,width: 70,height: 70,
    );
  }
}
