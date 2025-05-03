import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/domain/entities/investment.dart';
import 'package:meu_patrimonio/domain/entities/investment_category.dart';
import 'package:meu_patrimonio/ui/investments/view_models/investments_viewmodel.dart';
import 'package:meu_patrimonio/ui/widgets/buttons.dart';
import 'package:provider/provider.dart';

class CreateInvestmentScreen extends StatefulWidget {
  const CreateInvestmentScreen({super.key, this.investment});

  final Investment? investment;

  @override
  State<CreateInvestmentScreen> createState() => _CreateInvestmentScreenState();
}

class _CreateInvestmentScreenState extends State<CreateInvestmentScreen> with FormValidator {
  final _formKey = GlobalKey<FormState>();

  late InvestmentsViewmodel _viewModel;

  Investment? _investment;
  bool _isEditing = false;
  bool _shouldInputBalance = true;
  bool _shouldInputPrice = true;
  InvestmentCategory? _selectedCategory;

  final _nameTextController = TextEditingController();
  final _averagePriceTextController = TextEditingController();
  final _quantityTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _balanceTextController = TextEditingController();
  final _categoryTextController = TextEditingController();

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
    _quantityTextController.text = _investment?.quantity.toString() ?? "";
    _priceTextController.text = _shouldInputPrice ? formatToCurrency(_investment?.price) : "";
    _balanceTextController.text = _shouldInputBalance ? formatToCurrency(_investment?.balance()) : "";
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao excluir investimento ${_investment?.name}")));
    }
  }

  void _onSaveResult() {
    if (_viewModel.saveOrUpdateInvestment.completed) {
      _viewModel.saveOrUpdateInvestment.clearResult();
      Navigator.of(context).pop();
    }

    if (_viewModel.saveOrUpdateInvestment.error) {
      _viewModel.saveOrUpdateInvestment.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao salvar investmento ${_investment?.name}")));
    }
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
                  _viewModel.deleteInvestment.execute(_investment!.id);
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
    final category = _selectedCategory ?? InvestmentCategory(name: "Outros");

    if (_investment == null) {
      _investment = Investment(name: name, price: price ?? 0, averagePrice: averagePrice ?? 0, quantity: quantity, category: category);
    } else {
      _investment?.averagePrice = averagePrice ?? 0;
      _investment?.quantity = quantity;
      _investment?.price = price ?? 0;
      _investment?.category = category;
    }

    _viewModel.saveOrUpdateInvestment.execute(_investment!);
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
                const SizedBox(height: 16),
                ListenableBuilder(
                  listenable: _viewModel.loadInvestmentCategoryList,
                  builder: (context, child) {
                    if (_viewModel.loadInvestmentCategoryList.running) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return DropdownMenu<InvestmentCategory>(
                      initialSelection: _investment?.category,
                      dropdownMenuEntries:
                          _viewModel.investmentCategoryList.map((e) => DropdownMenuEntry<InvestmentCategory>(label: e.name, value: e)).toList(),
                      label: const Text("Categoria"),
                      expandedInsets: EdgeInsets.zero,
                      onSelected: (InvestmentCategory? value) {
                        _selectedCategory = value;
                      },
                    );
                  },
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
                  child: SecondaryButton(
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
