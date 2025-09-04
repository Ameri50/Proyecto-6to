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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // 🔹 Encabezado Perfil
          Text('Perfil', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),

          // 🔹 Tarjeta principal
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: .12),
                  child: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Ana Garcia',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18)),
                        SizedBox(height: 4),
                        Text('Gerente Financiero\nTecnologia Avanzada S.L.',
                            style: TextStyle(color: Colors.black54)),
                      ]),
                ),
              ]),
            ),
          ),

          const SizedBox(height: 6),

          // 🔹 Sección Info Personal
          const _SectionTitle('Información personal'),
          Card(
            child: Column(children: const [
              _InfoTile(label: 'Nombre completo', value: 'Ana Garcia'),
              Divider(height: 1),
              _InfoTile(
                  label: 'Correo electrónico', value: 'ana.garcia@teca-sl.com'),
              Divider(height: 1),
              _InfoTile(label: 'Teléfono', value: '+34 600 000 000'),
            ]),
          ),

          // 🔹 Sección Info Empresarial
          const _SectionTitle('Información empresarial'),
          Card(
            child: Column(children: const [
              _InfoTile(label: 'Empresa', value: 'Tecnologia Avanzada S.L.'),
              Divider(height: 1),
              _InfoTile(label: 'Cargo', value: 'Gerente Financiero'),
            ]),
          ),

          // 🔹 Control de tema oscuro
          const _SectionTitle('Preferencias'),
          Card(
            child: SwitchListTile(
              title: const Text("Modo oscuro",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              value: isDark,
              onChanged: onThemeChanged,
              secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(color: Colors.black54)),
      trailing: Text(value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }
}
