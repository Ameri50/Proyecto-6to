import 'package:flutter/material.dart';
import '../models/finance_models.dart';
import '../widgets/money_text.dart';
import '../widgets/summary_card.dart';
import '../widgets/trend_bar_chart.dart';

class DashboardScreen extends StatelessWidget {
  final FinanceAppState state;
  const DashboardScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('FinanceCloud'),
          actions: [
            IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: _HeaderCard(state: state),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SummaryCard(
                  label: 'Ingresos mensuales',
                  value: state.monthlyIncome,
                  icon: Icons.north_east,
                  color: Colors.green[700],
                ),
                SummaryCard(
                  label: 'Gastos mensuales',
                  value: state.monthlyExpense,
                  icon: Icons.south_west,
                  color: cs.error,
                ),
                SummaryCard(
                  label: 'Total ingresos',
                  value: state.totalIncomeAllTime,
                  icon: Icons.trending_up,
                ),
                SummaryCard(
                  label: 'Total gastos',
                  value: state.totalExpenseAllTime,
                  icon: Icons.trending_down,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tendencia mensual', style: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
                const SizedBox(height: 8),
                TrendBarChart(labels: state.months, values: state.monthlyTrend),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final FinanceAppState state;
  const _HeaderCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [cs.primary, cs.secondary]),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Saldo total', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white70)),
              const SizedBox(height: 6),
              MoneyText(state.dashboardTotalBalance, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withAlpha(15), borderRadius: BorderRadius.circular(30)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.trending_up, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(state.dashboardIndicator, style: const TextStyle(color: Colors.white)),
                ]),
              ),
            ]),
          ),
          const SizedBox(width: 12),
          Icon(Icons.cloud_done, size: 48, color: Colors.white.withValues(alpha: 0.9)),
        ],
      ),
    );
  }
}
