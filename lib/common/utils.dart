import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

const String _realSign = r'R$';

final CurrencyInputFormatter currencyInputFormatter = CurrencyInputFormatter(
  leadingSymbol: _realSign,
  useSymbolPadding: true,
  thousandSeparator: ThousandSeparator.Period,
);

String formatToCurrency(double? value) {
  return value
          ?.toString()
          .replaceAll('.', ',')
          .toCurrencyString(
            leadingSymbol: _realSign,
            useSymbolPadding: true,
            thousandSeparator: ThousandSeparator.Period,
          ) ??
      '';
}
