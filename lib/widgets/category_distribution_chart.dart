import 'package:flutter/material.dart';
import '../utils/format.dart';

class CategoryDistributionChart extends StatelessWidget {
  final Map<String, double> data;
  const CategoryDistributionChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold<double>(0, (a, b) => a + b);
    final cs = Theme.of(context).colorScheme;
    final colors = [
      cs.primary,
      cs.secondary,
      const Color(0xFF26C6DA),
      const Color(0xFF66BB6A),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distribución por categorías',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...data.entries.toList().asMap().entries.map((mapEntry) {
              final i = mapEntry.key;
              final entry = mapEntry.value;
              final name = entry.key;
              final value = entry.value;
              final pctVal = total == 0 ? 0.0 : value / total;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colors[i % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(name)),
                    Text(money(value)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: pctVal.toDouble(), // 👈 forzado a double
                          minHeight: 8,
                          color: colors[i % colors.length],
                          backgroundColor: Colors.black12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
