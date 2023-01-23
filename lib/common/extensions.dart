import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

const String _realSign = 'R\$';

extension StringExt on String {

  String removeCurrencyFormat() {
    return replaceAll('$_realSign ', '').replaceAll('.', '').replaceAll(',', '.');
  }

  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  double? toDoubleWithoutCurrency() {
    return double.tryParse(removeCurrencyFormat());
  }
}

extension DoubleExt on double {

  String toCurrency() {
    return toString().replaceAll('.', ',').toCurrencyString(
            leadingSymbol: _realSign,
            useSymbolPadding: true,
            thousandSeparator: ThousandSeparator.Period,
          );
  }
}