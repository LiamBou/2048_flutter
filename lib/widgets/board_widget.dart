import 'dart:math';
import 'package:deux_mille_quarante_huit/models/score_model.dart';
import 'package:deux_mille_quarante_huit/widgets/reset_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'number_case_widget.dart';
import '../const/colors.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  // Declare the board as a list of 16 integers
  List<int> board = List<int>.filled(16, 0);

  void _addTwoOrFour([int? nbToAdd]) {
    nbToAdd ??= 1;
    for (int i = 0; i < nbToAdd; i++) {
      int randomIndex = 0;
      do {
        randomIndex = Random().nextInt(16);
      } while (board[randomIndex] != 0);
      board[randomIndex] = 2; //Random().nextInt(2) == 0 ? 2 : 4;
    }
  }

  // This method generates a random board of 16 NumberCase widgets with only 2 random NumberCase not being 0
  GridView boardView() {
    return GridView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        return NumberCase(number: board[index], index: index);
      },
      itemCount: 16,
    );
  }

  void _handleSwipe(String direction) {
    if (_isNoMoreMovesPossible()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Game Over!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetBoard();
                },
              ),
            ],
          );
        },
      ).then((value) => _resetBoard());
      return;
    }
    // Handle the swipe in the specified direction
    if (direction == 'left') {
      _moveBasedOfDirection('left');
    } else if (direction == 'right') {
      _moveBasedOfDirection('right');
    } else if (direction == 'up') {
      _moveBasedOfDirection('up');
    } else if (direction == 'down') {
      _moveBasedOfDirection('down');
    }
  }

  bool _isNoMoreMovesPossible() {
    for (int i = 0; i < 16; i++) {
      if (board[i] == 0) {
        return false;
      }
    }
    for (int i = 0; i < 16; i++) {
      if (i % 4 != 3 && board[i] == board[i + 1]) {
        return false;
      }
      if (i < 12 && board[i] == board[i + 4]) {
        return false;
      }
    }
    return true;
  }

  bool _isBoardChanged(List<int> newBoard) {
    for (int i = 0; i < 16; i++) {
      if (board[i] != newBoard[i]) {
        return true;
      }
    }
    return false;
  }

  void _moveBasedOfDirection(String direction) {
    setState(() {
      List<int> newBoard = List<int>.filled(16, 0);

      if (direction == 'left') {
        for (int row = 0; row < 4; row++) {
          List<int> currentRow = [];
          for (int col = 0; col < 4; col++) {
            int value = board[row * 4 + col];
            if (value != 0) {
              currentRow.add(value);
            }
          }
          for (int i = 0; i < currentRow.length - 1; i++) {
            if (currentRow[i] == currentRow[i + 1]) {
              currentRow[i] *= 2;
              currentRow[i + 1] = 0;
            }
          }
          currentRow.removeWhere((value) => value == 0);
          for (int col = 0; col < currentRow.length; col++) {
            newBoard[row * 4 + col] = currentRow[col];
          }
        }
      } else if (direction == 'right') {
        for (int row = 0; row < 4; row++) {
          List<int> currentRow = [];
          for (int col = 3; col >= 0; col--) {
            int value = board[row * 4 + col];
            if (value != 0) {
              currentRow.add(value);
            }
          }
          for (int i = 0; i < currentRow.length - 1; i++) {
            if (currentRow[i] == currentRow[i + 1]) {
              currentRow[i] *= 2;
              currentRow[i + 1] = 0;
            }
          }
          currentRow.removeWhere((value) => value == 0);
          for (int col = 0; col < currentRow.length; col++) {
            newBoard[row * 4 + (3 - col)] = currentRow[col];
          }
        }
      } else if (direction == 'up') {
        for (int col = 0; col < 4; col++) {
          List<int> currentCol = [];
          for (int row = 0; row < 4; row++) {
            int value = board[row * 4 + col];
            if (value != 0) {
              currentCol.add(value);
            }
          }
          for (int i = 0; i < currentCol.length - 1; i++) {
            if (currentCol[i] == currentCol[i + 1]) {
              currentCol[i] *= 2;
              currentCol[i + 1] = 0;
            }
          }
          currentCol.removeWhere((value) => value == 0);
          for (int row = 0; row < currentCol.length; row++) {
            newBoard[row * 4 + col] = currentCol[row];
          }
        }
      } else if (direction == 'down') {
        for (int col = 0; col < 4; col++) {
          List<int> currentCol = [];
          for (int row = 3; row >= 0; row--) {
            int value = board[row * 4 + col];
            if (value != 0) {
              currentCol.add(value);
            }
          }
          for (int i = 0; i < currentCol.length - 1; i++) {
            if (currentCol[i] == currentCol[i + 1]) {
              currentCol[i] *= 2;
              currentCol[i + 1] = 0;
            }
          }
          currentCol.removeWhere((value) => value == 0);
          for (int row = 0; row < currentCol.length; row++) {
            newBoard[(3 - row) * 4 + col] = currentCol[row];
          }
        }
      }
      if (_isBoardChanged(newBoard)) {
        board = newBoard;
        _updateScoreAndBest();
        _addTwoOrFour();
      }
    });
  }

  // Add 10 points for each 2 added to the board and update the best score if needed
  void _updateScoreAndBest() {
    int score = Provider.of<ScoreModel>(context, listen: false).score;
    int best = Provider.of<ScoreModel>(context, listen: false).best;
    // Calculate the new score (sum of all the values in the board)
    int newScore =
        board.fold(0, (previousValue, element) => previousValue + element) + 2;
    Provider.of<ScoreModel>(context, listen: false).updateScore(newScore);
    if (newScore > best) {
      Provider.of<ScoreModel>(context, listen: false).updateBest(newScore);
    }
  }

  void _resetBoard() {
    setState(() {
      board = List<int>.filled(16, 0);
      _addTwoOrFour(2);
      Provider.of<ScoreModel>(context, listen: false).resetScore();
    });
  }

  @override
  void initState() {
    super.initState();
    _addTwoOrFour(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreModel>(
      builder: (context, scoreModel, child) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              _handleSwipe('right');
            } else if (details.primaryVelocity! < 0) {
              _handleSwipe('left');
            }
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              _handleSwipe('down');
            } else if (details.primaryVelocity! < 0) {
              _handleSwipe('up');
            }
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: ResetWidget(
                      resetGame: () => {
                            _resetBoard(),
                          }),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: colorBoard,
                  ),
                  constraints: const BoxConstraints(maxWidth: 1100),
                  alignment: Alignment.center,
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: boardView()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
