import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreModel extends ChangeNotifier {
  int _score = 0;
  int _best = 0;

  int get score => _score;
  int get best => _best;

  ScoreModel() {
    loadPreferences();
  }

  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void updateBest(int newBest) async {
    final prefs = await SharedPreferences.getInstance();
    _best = newBest;
    prefs.setInt('best', _best);
    notifyListeners();
  }

  void resetScore() async {
    _score = 0;
    notifyListeners();
  }

  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _best = prefs.getInt('best') ?? 0;
    notifyListeners();
  }
}
