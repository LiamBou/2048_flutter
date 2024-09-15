import 'package:deux_mille_quarante_huit/const/colors.dart';
import 'package:flutter/material.dart';

class ResetWidget extends StatelessWidget {
  const ResetWidget({super.key, required this.resetGame});

  final Function resetGame;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const CircleBorder(),
        ),
        onPressed: () {
          resetGame();
        },
        child: const Icon(Icons.refresh, color: colorBoard));
  }
}
