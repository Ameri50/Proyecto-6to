import 'package:flutter/material.dart';
import '../models/finance_models.dart';
import '../utils/format.dart';
import '../widgets/dual_line_chart.dart';
import '../widgets/category_distribution_chart.dart';

class ReportsScreen extends StatelessWidget {
  final FinanceAppState state;
  const ReportsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(title: const Text('Reportes')),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Financieros - Análisis y tendencias', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _StatCard(title: 'Variación gastos (este mes)', value: '+${pct(state.reportThisMonthExpenseVarPct)}'),
                  _StatCard(title: 'Margen beneficio', value: pct(state.reportThisMonthMarginPct)),
                ],
              ),
              const SizedBox(height: 8),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: DualLineChart(
            labels: state.months,
            seriesA: state.trendProfit,
            seriesB: state.trendExpense,
            labelA: 'Beneficio',
            labelB: 'Gastos',
          ),
        ),
        SliverToBoxAdapter(
          child: CategoryDistributionChart(data: state.categoryDistribution),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.insights, color: cs.primary),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ]),
      ]),
    );
  }
}
