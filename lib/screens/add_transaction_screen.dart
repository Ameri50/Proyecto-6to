import 'package:flutter/material.dart';
import '../models/finance_models.dart';
import '../utils/format.dart';

class AddTransactionScreen extends StatefulWidget {
  final void Function(FinanceTransaction) onSaved;
  const AddTransactionScreen({super.key, required this.onSaved});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  TxType _type = TxType.expense;

  final _amountCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _methodCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _categoryCtrl.dispose();
    _dateCtrl.dispose();
    _methodCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDate: _selectedDate ?? now,
      locale: const Locale('es'),
    );
    if (res != null) {
      setState(() {
        _selectedDate = res;
        _dateCtrl.text = dateShort(res);
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final tx = FinanceTransaction(
      title: _descCtrl.text.trim().split('\n').first,
      amount: double.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0,
      category: _categoryCtrl.text.trim(),
      date: _selectedDate ?? DateTime.now(),
      paymentMethod: _methodCtrl.text.trim().isEmpty ? 'N/D' : _methodCtrl.text.trim(),
      type: _type,
      description: _descCtrl.text.trim(),
    );
    widget.onSaved(tx);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transacción guardada')));
      _formKey.currentState!.reset();
      setState(() {
        _type = TxType.expense;
        _selectedDate = null;
        _dateCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Transacción')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Form(
          key: _formKey,
          child: Column(children: [
            // Selector Gasto/Ingreso
            SegmentedButton<TxType>(
              segments: const [
                ButtonSegment(value: TxType.expense, icon: Icon(Icons.south_west), label: Text('Gasto')),
                ButtonSegment(value: TxType.income, icon: Icon(Icons.north_east), label: Text('Ingreso')),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Monto*', prefixText: r'$ '),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _categoryCtrl,
              decoration: const InputDecoration(labelText: 'Categoría*'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _dateCtrl,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha*',
                suffixIcon: IconButton(icon: const Icon(Icons.calendar_today), onPressed: _pickDate),
              ),
              validator: (_) => _selectedDate == null ? 'Requerido' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _methodCtrl,
              decoration: const InputDecoration(labelText: 'Método de pago'),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _descCtrl,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Descripción*'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar Gasto'),
                style: FilledButton.styleFrom(backgroundColor: cs.primary),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
