import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions.dart';
import '../../../common/form_validator.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/investment.dart';
import '../../widgets/buttons.dart';
import '../view_models/investments_viewmodel.dart';

enum InputMode { averagePrice, appliedValue }

class CreateInvestmentScreen extends StatefulWidget {
  const CreateInvestmentScreen({super.key, this.investment});

  final Investment? investment;

  @override
  State<CreateInvestmentScreen> createState() => _CreateInvestmentScreenState();
}

class _CreateInvestmentScreenState extends State<CreateInvestmentScreen> with FormValidator {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final InvestmentsViewmodel _viewModel;
  Investment? _investment;
  bool _isEditing = false;

  InputMode _inputMode = InputMode.averagePrice;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _averagePriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _currentValueController = TextEditingController();
  final TextEditingController _appliedValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<InvestmentsViewmodel>();
    _viewModel.deleteInvestment.addListener(_onDeleteResult);
    _viewModel.saveOrUpdateInvestment.addListener(_onSaveResult);

    _investment = widget.investment;
    _isEditing = _investment != null;

    if (_isEditing) {
      _nameController.text = _investment!.name;
      _averagePriceController.text = formatToCurrency(_investment!.averagePrice);
      _quantityController.text = _investment!.quantity.toString();
      _currentValueController.text = formatToCurrency(_investment!.price);
      _appliedValueController.text = formatToCurrency(_investment!.averagePrice);
    }
  }

  @override
  void dispose() {
    _viewModel.deleteInvestment.removeListener(_onDeleteResult);
    _viewModel.saveOrUpdateInvestment.removeListener(_onSaveResult);
    _nameController.dispose();
    _averagePriceController.dispose();
    _quantityController.dispose();
    _currentValueController.dispose();
    _appliedValueController.dispose();
    super.dispose();
  }

  void _onDeleteResult() {
    if (_viewModel.deleteInvestment.completed) {
      _viewModel.deleteInvestment.clearResult();
      Navigator.of(context).pop();
    } else if (_viewModel.deleteInvestment.error) {
      _viewModel.deleteInvestment.clearResult();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao excluir investimento ${_investment?.name}')));
    }
  }

  void _onSaveResult() {
    if (_viewModel.saveOrUpdateInvestment.completed) {
      _viewModel.saveOrUpdateInvestment.clearResult();
      Navigator.of(context).pop();
    } else if (_viewModel.saveOrUpdateInvestment.error) {
      _viewModel.saveOrUpdateInvestment.clearResult();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar investimento ${_investment?.name}')));
    }
  }

  void _saveInvestment() {
    final name = _nameController.text.trim();
    final currentValue = _currentValueController.text.toDoubleWithoutCurrency() ?? 0;
    final inputAvgPrice = _averagePriceController.text.toDoubleWithoutCurrency() ?? 0;
    final intputQuantity = _quantityController.text.toDoubleOrNull() ?? 0;
    final inputAppliedValue = _appliedValueController.text.toDoubleWithoutCurrency() ?? 0;

    final double avgPrice =
        _inputMode == InputMode.averagePrice ? inputAvgPrice : inputAppliedValue;

    final double quantity = _inputMode == InputMode.averagePrice ? intputQuantity : 1;

    if (_investment == null) {
      _investment = Investment(
        name: name,
        price: currentValue,
        averagePrice: avgPrice,
        quantity: quantity,
      );
    } else {
      _investment!
        ..name = name
        ..averagePrice = avgPrice
        ..quantity = quantity
        ..price = currentValue;
    }

    _viewModel.saveOrUpdateInvestment.execute(_investment!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? _investment?.name ?? 'Editar investimento' : 'Novo investimento'),
        actions: [
          if (_isEditing)
            IconButton(icon: const Icon(Icons.delete), onPressed: () => _showDeleteConfirmation()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !_isEditing,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: isNotEmpty,
                  ),
                ),
                const SizedBox(height: 16),
                // Mode selector
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Por preço médio'),
                        selected: _inputMode == InputMode.averagePrice,
                        onSelected: (_) {
                          setState(() => _inputMode = InputMode.averagePrice);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Por valor aplicado'),
                        selected: _inputMode == InputMode.appliedValue,
                        onSelected: (_) {
                          setState(() => _inputMode = InputMode.appliedValue);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_inputMode == InputMode.averagePrice) ...[
                  TextFormField(
                    controller: _averagePriceController,
                    inputFormatters: [currencyInputFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Preço médio',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator:
                        (v) => combineValidations([
                          () => isNotEmpty(v),
                          () => isValidDecimal(v?.removeCurrencyFormat()),
                        ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade/Cotas',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator:
                        (v) => combineValidations([() => isNotEmpty(v), () => isValidDecimal(v)]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _currentValueController,
                    inputFormatters: [currencyInputFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Preço atual',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator:
                        (v) => combineValidations([
                          () => isNotEmpty(v),
                          () => isValidDecimal(v?.removeCurrencyFormat()),
                        ]),
                  ),
                ] else ...[
                  TextFormField(
                    controller: _appliedValueController,
                    inputFormatters: [currencyInputFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Valor aplicado',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator:
                        (v) => combineValidations([
                          () => isNotEmpty(v),
                          () => isValidDecimal(v?.removeCurrencyFormat()),
                        ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _currentValueController,
                    inputFormatters: [currencyInputFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Valor atual',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator:
                        (v) => combineValidations([
                          () => isNotEmpty(v),
                          () => isValidDecimal(v?.removeCurrencyFormat()),
                        ]),
                  ),
                ],
                const SizedBox(height: 24),
                PrimaryButton(
                  text: _isEditing ? 'Salvar investimento' : 'Inserir investimento',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveInvestment();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Excluir ${_investment?.name}?'),
            content: const Text('Deseja excluir permanentemente este investimento?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _viewModel.deleteInvestment.execute(_investment!.id);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
    );
  }
}
