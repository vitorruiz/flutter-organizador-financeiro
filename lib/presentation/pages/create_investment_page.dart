import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/presentation/blocs/investment_notifier.dart';
import 'package:meu_patrimonio/presentation/widgets/buttons.dart';

class CreateInvestmentPage extends ConsumerStatefulWidget {
  const CreateInvestmentPage({super.key, this.investment});

  final Investment? investment;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateInvestmentState();
}

class _CreateInvestmentState extends ConsumerState<CreateInvestmentPage> with FormValidator {
  final _formKey = GlobalKey<FormState>();
  InvestmentNotifier? _investmentNotifier;

  Investment? _investment;
  bool _isEditing = false;
  bool _shouldInputBalance = true;
  bool _shouldInputPrice = true;

  final _nameTextController = TextEditingController();
  final _averagePriceTextController = TextEditingController();
  final _quantityTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _balanceTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _investmentNotifier = ref.read(investmentListProvider.notifier);
    _investment = widget.investment;
    _isEditing = _investment != null;

    _priceTextController.addListener(_handleBalancePriceChanges);
    _balanceTextController.addListener(_handleBalancePriceChanges);

    _averagePriceTextController.text = formatToCurrency(_investment?.averagePrice);
    _quantityTextController.text = _investment?.quantity.toString() ?? "";
    _priceTextController.text = _shouldInputPrice ? formatToCurrency(_investment?.price) : "";
    _balanceTextController.text = _shouldInputBalance ? formatToCurrency(_investment?.balance()) : "";
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          ((context) => AlertDialog(
            title: Text("Excluir ${_investment?.name}?"),
            content: Text("Deseja realmente excluir permanentemente o investimento ${_investment?.name}"),
            actions: [
              TextButton(onPressed: (() => Navigator.pop(context)), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // _repository.delete(_investment!.id).then((value) => Navigator.pop(context));
                  // _repository.delete(_investment!.id);
                  _investmentNotifier?.delete(_investment!.id);
                  Navigator.pop(context);
                },
                child: const Text('Sim'),
              ),
            ],
          )),
    );
  }

  void _handleBalancePriceChanges() {
    double price = _priceTextController.text.toDoubleWithoutCurrency() ?? 0;
    double balance = _balanceTextController.text.toDoubleWithoutCurrency() ?? 0;
    setState(() {
      _shouldInputBalance = price == 0;
      _shouldInputPrice = balance == 0;
    });
  }

  void _saveInvestment() {
    final name = _nameTextController.text;
    final averagePrice = _averagePriceTextController.text.toDoubleWithoutCurrency();
    final quantity = _quantityTextController.text.toDouble();
    final price = _priceTextController.text.toDoubleWithoutCurrency();
    final balance = _balanceTextController.text.toDoubleWithoutCurrency();

    if (_investment == null) {
      _investment = Investment(name: name, price: price ?? 0, averagePrice: averagePrice ?? 0, quantity: quantity);
    } else {
      _investment?.averagePrice = averagePrice ?? 0;
      _investment?.quantity = quantity;
      _investment?.price = price ?? 0;
    }

    _investmentNotifier?.saveOrUpdate(_investment!).then((value) => {if (mounted) Navigator.pop(context)});

    // if (_isEditing) {
    //   if (_repository.update(_investment!.id, _investment!.name, price ?? 0, averagePrice ?? 0, quantity)) {
    //     Navigator.pop(context);
    //   }
    // } else {
    //   if (_repository.create(name, price ?? 0, averagePrice ?? 0, quantity)) {
    //     Navigator.pop(context);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_investment?.name ?? "Novo investimento")),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: !_isEditing,
                  child: TextFormField(
                    controller: _nameTextController,
                    decoration: const InputDecoration(labelText: "Nome", border: OutlineInputBorder()),
                    validator: _isEditing ? null : isNotEmpty,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _averagePriceTextController,
                  inputFormatters: [currencyInputFormatter],
                  decoration: const InputDecoration(labelText: "Preço médio", border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) => combineValidations([() => isNotEmpty(value), () => isValidDecimal(value?.removeCurrencyFormat())]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityTextController,
                  decoration: const InputDecoration(labelText: "Quantidade/Cotas", border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) => combineValidations([() => isNotEmpty(value), () => isValidDecimal(value)]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: _shouldInputPrice,
                  controller: _priceTextController,
                  inputFormatters: [currencyInputFormatter],
                  decoration: const InputDecoration(labelText: "Preço atual", border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) => combineValidations([() => isValidDecimal(value?.removeCurrencyFormat())]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: _shouldInputBalance,
                  controller: _balanceTextController,
                  inputFormatters: [currencyInputFormatter],
                  decoration: const InputDecoration(labelText: "Saldo atual", border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) => combineValidations([() => isValidDecimal(value?.removeCurrencyFormat())]),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: _isEditing ? "Salvar investimento" : "Inserir investimento",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveInvestment();
                    }
                  },
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: _investment != null,
                  child: ErrorTextButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog();
                    },
                    text: "Excluir",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
