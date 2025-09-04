import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfileScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: isDark ? "Cambiar a modo claro" : "Cambiar a modo oscuro",
            onPressed: () => onThemeChanged(!isDark),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            const Text("Usuario Demo", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 24),

            // 🔥 Switch para modo oscuro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Modo oscuro", style: TextStyle(fontSize: 16)),
                Switch(
                  value: isDark,
                  onChanged: onThemeChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
