import 'package:flutter/material.dart';

class DualLineChart extends StatelessWidget {
  final List<String> labels; // Ej: ['Ene'..]
  final List<double> seriesA; // Beneficio
  final List<double> seriesB; // Gastos
  final String labelA;
  final String labelB;

  const DualLineChart({
    super.key,
    required this.labels,
    required this.seriesA,
    required this.seriesB,
    required this.labelA,
    required this.labelB,
  });

  @override
  Widget build(BuildContext context) {
    assert(labels.length == seriesA.length && labels.length == seriesB.length);
    final maxV = [
      ...seriesA,
      ...seriesB,
    ].reduce((a, b) => a > b ? a : b) * 1.25;

    final cs = Theme.of(context).colorScheme;

    return Card(
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: CustomPaint(
            painter: _DualLinePainter(
              labels: labels,
              a: seriesA,
              b: seriesB,
              maxV: maxV,
              colorA: cs.primary,
              colorB: cs.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _LegendDot(color: cs.primary, text: labelA),
                  const SizedBox(width: 12),
                  _LegendDot(color: cs.secondary, text: labelB),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendDot({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 12)),
    ]);
  }
}

class _DualLinePainter extends CustomPainter {
  final List<String> labels;
  final List<double> a;
  final List<double> b;
  final double maxV;
  final Color colorA;
  final Color colorB;

  _DualLinePainter({
    required this.labels,
    required this.a,
    required this.b,
    required this.maxV,
    required this.colorA,
    required this.colorB,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height - 50;
    final stepX = size.width / (labels.length - 1);

    Offset p(double xIdx, double v) {
      final x = xIdx * stepX;
      final y = chartHeight - (v / maxV) * chartHeight + 10;
      return Offset(x, y);
    }

    void drawSeries(List<double> s, Color c) {
      final paint = Paint()
        ..color = c
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      final path = Path()..moveTo(0, p(0, s[0]).dy);
      for (int i = 0; i < s.length; i++) {
        final pt = p(i.toDouble(), s[i]);
        if (i == 0) {
          path.moveTo(pt.dx, pt.dy);
        } else {
          path.lineTo(pt.dx, pt.dy);
        }
      }
      canvas.drawPath(path, paint);

      // puntos
      final dot = Paint()..color = c;
      for (int i = 0; i < s.length; i++) {
        final pt = p(i.toDouble(), s[i]);
        canvas.drawCircle(pt, 3.5, dot);
      }
    }

    // grid horizontal suave
    final grid = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = 10 + (chartHeight / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    drawSeries(a, colorA);
    drawSeries(b, colorB);

    // labels eje X
    final tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    for (int i = 0; i < labels.length; i++) {
      tp.text = TextSpan(
        text: labels[i],
        style: const TextStyle(color: Colors.black54, fontSize: 12),
      );
      tp.layout(minWidth: 1, maxWidth: 80);
      final x = i * stepX - tp.width / 2;
      tp.paint(
        canvas,
        Offset(x.clamp(0, size.width - tp.width), size.height - 22),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DualLinePainter oldDelegate) => true;
}
