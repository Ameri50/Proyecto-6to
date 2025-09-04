enum TxType { expense, income }

class FinanceTransaction {
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String paymentMethod;
  final TxType type;
  final String description;

  FinanceTransaction({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.paymentMethod,
    required this.type,
    required this.description,
  });
}

class FinanceAppState {
  // Totales estáticos requeridos (no calculados de la lista)
  final double dashboardTotalBalance = 0;
  final String dashboardIndicator = "+20 Este mes";
  final double monthlyIncome = 0;
  final double monthlyExpense = 20;
  final double totalIncomeAllTime = 122314235871; // $122,314,235,871
  final double totalExpenseAllTime = 12231423587; // "$122,314,235,87" -> asumimos 11 dígitos faltaba un 1

  // Tendencia mensual Ene-Jun
  final List<String> months = const ['Ene', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final List<double> monthlyTrend = const [12, 18, 9, 15, 22, 11];

  // Reportes
  final double reportThisMonthExpenseVarPct = 9.9; // +9.9%
  final double reportThisMonthMarginPct = 34.1; // 34.1%
  final List<double> trendProfit = const [8, 12, 10, 14, 18, 16];
  final List<double> trendExpense = const [10, 9, 11, 13, 15, 12];
  final Map<String, double> categoryDistribution = const {
    'Transporte': 2840,
    'Alimentación': 2130,
    'Suministros': 1890,
  };

  // Lista de transacciones (demo)
  final List<FinanceTransaction> transactions;

  FinanceAppState({required this.transactions});

  factory FinanceAppState.seed() => FinanceAppState(transactions: [
        FinanceTransaction(
          title: 'Compra combustible',
          amount: 120.5,
          category: 'Transporte',
          date: DateTime.now().subtract(const Duration(days: 1)),
          paymentMethod: 'Tarjeta Visa',
          type: TxType.expense,
          description: 'Combustible flota',
        ),
        FinanceTransaction(
          title: 'Venta contrato SaaS',
          amount: 5400,
          category: 'Ventas',
          date: DateTime.now().subtract(const Duration(days: 2)),
          paymentMethod: 'Transferencia',
          type: TxType.income,
          description: 'Pago trimestral',
        ),
        FinanceTransaction(
          title: 'Almuerzo equipo',
          amount: 86.9,
          category: 'Alimentación',
          date: DateTime.now().subtract(const Duration(days: 3)),
          paymentMethod: 'Tarjeta MasterCard',
          type: TxType.expense,
          description: 'Reunión comercial',
        ),
      ]);
}
