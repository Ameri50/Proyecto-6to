import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text('Perfil', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: .12),
                child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Ana Garcia', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                  SizedBox(height: 4),
                  Text('Gerente Financiero\nTecnologia Avanzada S.L.', style: TextStyle(color: Colors.black54)),
                ]),
              ),
            ]),
          ),
        ),

        const SizedBox(height: 6),
        _SectionTitle('Información personal'),
        Card(
          child: Column(children: const [
            _InfoTile(label: 'Nombre completo', value: 'Ana Garcia'),
            Divider(height: 1),
            _InfoTile(label: 'Correo electrónico', value: 'ana.garcia@teca-sl.com'),
            Divider(height: 1),
            _InfoTile(label: 'Teléfono', value: '+34 600 000 000'),
          ]),
        ),

        _SectionTitle('Información empresarial'),
        Card(
          child: Column(children: const [
            _InfoTile(label: 'Empresa', value: 'Tecnologia Avanzada S.L.'),
            Divider(height: 1),
            _InfoTile(label: 'Cargo', value: 'Gerente Financiero'),
          ]),
        ),
      ],
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
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
