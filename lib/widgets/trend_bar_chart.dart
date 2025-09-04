import 'package:flutter/material.dart';

class TrendBarChart extends StatelessWidget {
  final List<String> labels; // Ej: ['Ene', 'Feb', ...]
  final List<double> values; // misma longitud

  const TrendBarChart({super.key, required this.labels, required this.values});

  @override
  Widget build(BuildContext context) {
    assert(labels.length == values.length && labels.isNotEmpty);
    final maxV = (values.reduce((a, b) => a > b ? a : b)) * 1.2;

    return Card(
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: CustomPaint(
            painter: _BarPainter(labels: labels, values: values, maxV: maxV, color: Theme.of(context).colorScheme.primary),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _BarPainter extends CustomPainter {
  final List<String> labels;
  final List<double> values;
  final double maxV;
  final Color color;

  _BarPainter({required this.labels, required this.values, required this.maxV, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const barWidth = 22.0;
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    final gap = (size.width - (labels.length * barWidth)) / (labels.length + 1);

    for (int i = 0; i < labels.length; i++) {
      final x = gap + i * (barWidth + gap);
      final h = (values[i] / maxV) * (size.height - 40);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - h - 30, barWidth, h),
        const Radius.circular(6),
      );
      canvas.drawRRect(rect, paint);

      // etiqueta
      textPainter.text = TextSpan(text: labels[i], style: const TextStyle(color: Colors.black54, fontSize: 12));
      textPainter.layout(minWidth: barWidth, maxWidth: barWidth);
      textPainter.paint(canvas, Offset(x, size.height - 24));
    }

    // Línea base
    final base = Paint()..color = Colors.black12..strokeWidth = 1;
    canvas.drawLine(Offset(0, size.height - 30), Offset(size.width, size.height - 30), base);
  }

  @override
  bool shouldRepaint(covariant _BarPainter old) => old.values != values || old.color != color;
}
