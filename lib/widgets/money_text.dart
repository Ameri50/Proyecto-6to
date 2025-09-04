import 'package:flutter/material.dart';
import '../utils/format.dart';

class MoneyText extends StatelessWidget {
  final num value;
  final TextStyle? style;
  final Color? color;

  const MoneyText(this.value, {super.key, this.style, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      money(value),
      style: (style ?? Theme.of(context).textTheme.titleMedium)?.copyWith(
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
