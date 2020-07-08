import 'package:intl/intl.dart' show NumberFormat;

class CurrencyFormat {
  static String format(double value, {String symbol}) {
    if (value > 999999) {
      return NumberFormat.compactSimpleCurrency(
        name: symbol,
        decimalDigits: 2,
      ).format(value);
    }
    return NumberFormat.simpleCurrency(
      name: symbol,
      decimalDigits: 2,
    ).format(value);
  }
}
