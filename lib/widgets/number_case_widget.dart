import 'package:deux_mille_quarante_huit/const/colors.dart';
import 'package:flutter/material.dart';

class NumberCase extends StatefulWidget {
  const NumberCase({super.key, required this.number, required this.index});

  final int number;
  final int index;

  @override
  State<NumberCase> createState() => _NumberCaseState();
}

class _NumberCaseState extends State<NumberCase> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: numberCaseColor[widget.number],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.number == 0
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              : Text(
                  widget.number.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
