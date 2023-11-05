import 'package:flutter/material.dart';

class BudgetUsageIndicator extends StatelessWidget {
  const BudgetUsageIndicator({
    super.key,
    required this.value,
    this.size,
    this.color = Colors.purpleAccent,
    this.backgroundColor = Colors.grey,
    this.strokeWidth = 10,
  });

  final double value;
  final double? size;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            color: color,
            backgroundColor: backgroundColor,
          ),
        ),
        Text(
          '60%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ],
    );
  }
}
