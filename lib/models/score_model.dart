import 'package:flutter/material.dart';

class ScoreModel extends ChangeNotifier {
  int _score = 0;
  int _best = 0;

  int get score => _score;
  int get best => _best;

  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void updateBest(int newBest) {
    _best = newBest;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
