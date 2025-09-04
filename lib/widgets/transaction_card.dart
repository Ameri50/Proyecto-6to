import 'package:flutter/material.dart';
import '../models/finance_models.dart';
import '../utils/format.dart';
import 'money_text.dart';

class TransactionCard extends StatelessWidget {
  final FinanceTransaction tx;
  const TransactionCard({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isExpense = tx.type == TxType.expense;
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (isExpense ? cs.error : cs.primary).withValues(alpha: .12),
          child: Icon(isExpense ? Icons.south_west : Icons.north_east, color: isExpense ? cs.error : cs.primary),
        ),
        title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${tx.category} • ${dateShort(tx.date)} • ${tx.paymentMethod}'),
        trailing: MoneyText(
          isExpense ? -tx.amount : tx.amount,
          color: isExpense ? cs.error : Colors.green[700],
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
