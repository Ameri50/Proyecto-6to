import 'package:intl/intl.dart';

final _money = NumberFormat.currency(locale: 'en_US', symbol: r'$'); // $123,456.78
final _date = DateFormat('dd/MM/yyyy');

String money(num value) => _money.format(value);
String dateShort(DateTime d) => _date.format(d);

// Utilidad corta para porcentajes con una decimal y símbolo
String pct(num value) => '${value.toStringAsFixed(1)}%';
