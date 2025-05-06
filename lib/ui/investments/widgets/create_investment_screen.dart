import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions.dart';
import '../../../common/form_validator.dart';
import '../../../common/utils.dart';
import '../../../domain/entities/investment.dart';
import '../../../domain/entities/investment_category.dart';
import '../../widgets/buttons.dart';
import '../view_models/investments_viewmodel.dart';

class CreateInvestmentScreen extends StatefulWidget {
  const CreateInvestmentScreen({super.key, this.investment});

  final Investment? investment;

  @override
  State<CreateInvestmentScreen> createState() => _CreateInvestmentScreenState();
}

class _CreateInvestmentScreenState extends State<CreateInvestmentScreen> with FormValidator {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late InvestmentsViewmodel _viewModel;

  Investment? _investment;
  bool _isEditing = false;
  bool _shouldInputBalance = true;
  bool _shouldInputPrice = true;
  InvestmentCategory? _selectedCategory;

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _averagePriceTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _balanceTextController = TextEditingController();
  final TextEditingController _categoryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _viewModel = context.read<InvestmentsViewmodel>();

    _viewModel.deleteInvestment.addListener(_onDeleteResult);
    _viewModel.saveOrUpdateInvestment.addListener(_onSaveResult);

    _investment = widget.investment;
    _isEditing = _investment != null;

    _priceTextController.addListener(_handleBalancePriceChanges);
    _balanceTextController.addListener(_handleBalancePriceChanges);

    _averagePriceTextController.text = formatToCurrency(_investment?.averagePrice);
    _quantityTextController.text = _investment?.quantity.toString() ?? '';
    _priceTextController.text = _shouldInputPrice ? formatToCurrency(_investment?.price) : '';
    _balanceTextController.text =
        _shouldInputBalance ? formatToCurrency(_investment?.balance()) : '';
  }

  @override
  void dispose() {
    _viewModel.deleteInvestment.removeListener(_onDeleteResult);
    _viewModel.saveOrUpdateInvestment.removeListener(_onSaveResult);
    super.dispose();
  }

  void _onDeleteResult() {
    if (_viewModel.deleteInvestment.completed) {
      _viewModel.deleteInvestment.clearResult();
      Navigator.of(context).pop();
    }

    if (_viewModel.deleteInvestment.error) {
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
    }

    if (_viewModel.saveOrUpdateInvestment.error) {
      _viewModel.saveOrUpdateInvestment.clearResult();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar investmento ${_investment?.name}')));
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: Text('Excluir ${_investment?.name}?'),
            content: Text(
              'Deseja realmente excluir permanentemente o investimento ${_investment?.name}',
            ),
            actions: <Widget>[
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

  void _handleBalancePriceChanges() {
    final double price = _priceTextController.text.toDoubleWithoutCurrency() ?? 0;
    final double balance = _balanceTextController.text.toDoubleWithoutCurrency() ?? 0;
    setState(() {
      _shouldInputBalance = price == 0;
      _shouldInputPrice = balance == 0;
    });
  }

  void _saveInvestment() {
    final String name = _nameTextController.text;
    final double? averagePrice = _averagePriceTextController.text.toDoubleWithoutCurrency();
    final double quantity = _quantityTextController.text.toDouble();
    final double? price = _priceTextController.text.toDoubleWithoutCurrency();
    final double? balance = _balanceTextController.text.toDoubleWithoutCurrency();
    final InvestmentCategory category = _selectedCategory ?? InvestmentCategory(name: 'Outros');

    if (_investment == null) {
      _investment = Investment(
        name: name,
        price: price ?? 0,
        averagePrice: averagePrice ?? 0,
        quantity: quantity,
      );
    } else {
      _investment?.averagePrice = averagePrice ?? 0;
      _investment?.quantity = quantity;
      _investment?.price = price ?? 0;
    }

    _viewModel.saveOrUpdateInvestment.execute(_investment!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_investment?.name ?? 'Novo investimento')),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: !_isEditing,
                  child: TextFormField(
                    controller: _nameTextController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                    validator: _isEditing ? null : isNotEmpty,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _averagePriceTextController,
                  inputFormatters: <TextInputFormatter>[currencyInputFormatter],
                  decoration: const InputDecoration(
                    labelText: 'Preço médio',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator:
                      (String? value) => combineValidations(<String? Function()>[
                        () => isNotEmpty(value),
                        () => isValidDecimal(value?.removeCurrencyFormat()),
                      ]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityTextController,
                  decoration: const InputDecoration(
                    labelText: 'Quantidade/Cotas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator:
                      (String? value) => combineValidations(<String? Function()>[
                        () => isNotEmpty(value),
                        () => isValidDecimal(value),
                      ]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: _shouldInputPrice,
                  controller: _priceTextController,
                  inputFormatters: <TextInputFormatter>[currencyInputFormatter],
                  decoration: const InputDecoration(
                    labelText: 'Preço atual',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator:
                      (String? value) =>
                          combineValidations(<String? Function()>[() => isValidDecimal(value?.removeCurrencyFormat())]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  enabled: _shouldInputBalance,
                  controller: _balanceTextController,
                  inputFormatters: <TextInputFormatter>[currencyInputFormatter],
                  decoration: const InputDecoration(
                    labelText: 'Saldo atual',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator:
                      (String? value) =>
                          combineValidations(<String? Function()>[() => isValidDecimal(value?.removeCurrencyFormat())]),
                ),
                const SizedBox(height: 16),
                // ListenableBuilder(
                //   listenable: _viewModel.loadInvestmentCategoryList,
                //   builder: (BuildContext context, Widget? child) {
                //     if (_viewModel.loadInvestmentCategoryList.running) {
                //       return const Center(child: CircularProgressIndicator());
                //     }

                //     return DropdownMenu<InvestmentCategory>(
                //       initialSelection: _investment?.category,
                //       dropdownMenuEntries:
                //           _viewModel.investmentCategoryList
                //               .map(
                //                 (InvestmentCategory e) =>
                //                     DropdownMenuEntry<InvestmentCategory>(label: e.name, value: e),
                //               )
                //               .toList(),
                //       label: const Text('Categoria'),
                //       expandedInsets: EdgeInsets.zero,
                //       onSelected: (InvestmentCategory? value) {
                //         _selectedCategory = value;
                //       },
                //     );
                //   },
                // ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: _isEditing ? 'Salvar investimento' : 'Inserir investimento',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveInvestment();
                    }
                  },
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: _investment != null,
                  child: SecondaryButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog();
                    },
                    text: 'Excluir',
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
