import 'package:flutter/material.dart';
import 'money_text.dart';

class SummaryCard extends StatelessWidget {
  final String label;
  final num value;
  final IconData icon;
  final Color? color;
  final String? helper;

  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
    this.helper,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (color ?? cs.secondary).withValues(alpha: .12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color ?? cs.secondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 4),
                  MoneyText(value, style: Theme.of(context).textTheme.titleLarge),
                  if (helper != null) ...[
                    const SizedBox(height: 2),
                    Text(helper!, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black54)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
