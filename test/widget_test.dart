import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App muestra los íconos en NavigationBar y el botón de tema',
      (WidgetTester tester) async {
    // 🚀 Construimos una app mínima con soporte de tema
    ThemeMode themeMode = ThemeMode.light;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Perfil'),
                actions: [
                  IconButton(
                    key: const Key('themeToggle'),
                    icon: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                    ),
                    onPressed: () {
                      setState(() {
                        themeMode = themeMode == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                      });
                    },
                  ),
                ],
              ),
              bottomNavigationBar: NavigationBar(
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    label: 'Inicio',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.add_circle_outline),
                    label: 'Agregar',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.receipt_long_outlined),
                    label: 'Transacciones',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.show_chart_outlined),
                    label: 'Reportes',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    label: 'Perfil',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    // 🔎 Verificar que existen los íconos en el NavigationBar
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);
    expect(find.byIcon(Icons.show_chart_outlined), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);

    // 🔎 Verificar que el botón de tema existe (inicia en modo claro → muestra dark_mode)
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);

    // 🚀 Simular un tap para cambiar a modo oscuro
    await tester.tap(find.byKey(const Key('themeToggle')));
    await tester.pump();

    // 🔎 Ahora debería aparecer el ícono de modo claro
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
  });
}
