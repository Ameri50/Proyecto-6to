import 'package:flutter/material.dart';
import '../models/finance_models.dart';
import '../widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  final FinanceAppState state;
  const TransactionsScreen({super.key, required this.state});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _query = '';
  String _typeFilter = 'Todos';
  String _categoryFilter = 'Todas';

  @override
  Widget build(BuildContext context) {
    final txs = widget.state.transactions.where((t) {
      final q = _query.toLowerCase();
      final matchesQuery = _query.isEmpty ||
          t.title.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q) ||
          t.paymentMethod.toLowerCase().contains(q);
      final matchesType = _typeFilter == 'Todos' ||
          (_typeFilter == 'Gastos' && t.type == TxType.expense) ||
          (_typeFilter == 'Ingresos' && t.type == TxType.income);
      final matchesCat = _categoryFilter == 'Todas' || t.category == _categoryFilter;
      return matchesQuery && matchesType && matchesCat;
    }).toList();

    final categories = {
      'Todas',
      ...widget.state.transactions.map((e) => e.category),
    }.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Transacciones')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resumen fijo segun requerimiento
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _SummaryChip(label: 'Gastos', value: ' \$122314235871.00'),
                _SummaryChip(label: 'Ingresos', value: ' \$122314235871.00'),
              ],
            ),
          ),

          // Buscador
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar transacciones...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),

          // Filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              DropdownButton<String>(
                value: _typeFilter,
                items: const [
                  DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                  DropdownMenuItem(value: 'Gastos', child: Text('Gastos')),
                  DropdownMenuItem(value: 'Ingresos', child: Text('Ingresos')),
                ],
                onChanged: (v) => setState(() => _typeFilter = v!),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _categoryFilter,
                items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _categoryFilter = v!),
              ),
            ]),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: txs.length,
              itemBuilder: (_, i) => TransactionCard(tx: txs[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Text(value, style: TextStyle(color: cs.primary, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
