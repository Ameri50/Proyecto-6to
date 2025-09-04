import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'models/finance_models.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const FinanceCloudApp());
}

class FinanceCloudApp extends StatefulWidget {
  const FinanceCloudApp({super.key});

  @override
  State<FinanceCloudApp> createState() => _FinanceCloudAppState();
}

class _FinanceCloudAppState extends State<FinanceCloudApp> {
  int _currentIndex = 0;

  // Estado simple en memoria para demo
  final FinanceAppState _state = FinanceAppState.seed();

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(state: _state),
      AddTransactionScreen(
        onSaved: (tx) => setState(() => _state.transactions.insert(0, tx)),
      ),
      TransactionsScreen(state: _state),
      ReportsScreen(state: _state),
      const ProfileScreen(),
    ];

    return MaterialApp(
      title: 'FinanceCloud',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: Scaffold(
        body: SafeArea(child: screens[_currentIndex]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (i) => setState(() => _currentIndex = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
            NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Agregar'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Transacciones'),
            NavigationDestination(icon: Icon(Icons.show_chart_outlined), selectedIcon: Icon(Icons.show_chart), label: 'Reportes'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
