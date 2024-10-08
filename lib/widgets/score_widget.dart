import 'package:deux_mille_quarante_huit/const/colors.dart';
import 'package:deux_mille_quarante_huit/models/score_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key, required this.best});

  final bool best;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreModel>(
      builder: (context, scoreModel, child) {
        return Container(
          width: best ? 150 : 140,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorBoard,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  best ? 'Best Score :' : 'Score :',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${best ? scoreModel.best : scoreModel.score}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
