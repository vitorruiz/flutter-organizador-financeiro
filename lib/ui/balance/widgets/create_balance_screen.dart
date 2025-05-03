import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:meu_patrimonio/ui/balance/view_models/balance_viewmodel.dart';
import 'package:meu_patrimonio/ui/widgets/buttons.dart';
import 'package:provider/provider.dart';

class CreateBalanceScreen extends StatefulWidget {
  const CreateBalanceScreen({super.key, this.account});

  final AccountBalance? account;

  @override
  State<CreateBalanceScreen> createState() => _CreateBalanceScreenState();
}

class _CreateBalanceScreenState extends State<CreateBalanceScreen> with FormValidator {
  final _formKey = GlobalKey<FormState>();

  late BalanceViewmodel _viewModel;

  AccountBalance? _account;

  final _accountNameTextController = TextEditingController();
  final _balanceTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _viewModel = context.read<BalanceViewmodel>();

    _viewModel.deleteAccountBalance.addListener(_onDeleteResult);
    _viewModel.saveOrUpdateAccountBalance.addListener(_onSaveResult);

    _account = widget.account;
    _balanceTextController.text = formatToCurrency(widget.account?.balance);
  }

  @override
  void dispose() {
    _viewModel.deleteAccountBalance.removeListener(_onDeleteResult);
    _viewModel.saveOrUpdateAccountBalance.removeListener(_onSaveResult);
    super.dispose();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          ((context) => AlertDialog(
            title: Text("Excluir ${_account?.name}?"),
            content: Text("Deseja realmente excluir permanentemente a conta ${_account?.name}"),
            actions: [
              TextButton(onPressed: (() => Navigator.pop(context)), child: const Text('Cancelar')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _viewModel.deleteAccountBalance.execute(_account!.id);
                },
                child: const Text('Sim'),
              ),
            ],
          )),
    );
  }

  void _saveAccountBalance() {
    if (_account == null) {
      _account = AccountBalance(name: _accountNameTextController.text, balance: double.parse(_balanceTextController.text.removeCurrencyFormat()));
    } else {
      _account?.balance = double.parse(_balanceTextController.text.removeCurrencyFormat());
    }

    _viewModel.saveOrUpdateAccountBalance.execute(_account!);
    // _accountBalanceNotifier?.saveOrUpdate(_account!).then((value) => {if (mounted) Navigator.of(context).pop()});
  }

  void _onDeleteResult() {
    if (_viewModel.deleteAccountBalance.completed) {
      _viewModel.deleteAccountBalance.clearResult();
      Navigator.of(context).pop();
    }

    if (_viewModel.deleteAccountBalance.error) {
      _viewModel.deleteAccountBalance.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao excluir conta ${_account?.name}")));
    }
  }

  void _onSaveResult() {
    if (_viewModel.saveOrUpdateAccountBalance.completed) {
      _viewModel.saveOrUpdateAccountBalance.clearResult();
      Navigator.of(context).pop();
    }

    if (_viewModel.saveOrUpdateAccountBalance.error) {
      _viewModel.saveOrUpdateAccountBalance.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao salvar conta ${_account?.name}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_account?.name ?? "Nova conta")),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Visibility(
                visible: _account == null,
                child: TextFormField(
                  controller: _accountNameTextController,
                  decoration: const InputDecoration(labelText: "Conta", border: OutlineInputBorder()),
                  validator: _account == null ? isNotEmpty : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _balanceTextController,
                inputFormatters: [currencyInputFormatter],
                decoration: const InputDecoration(labelText: "Saldo", border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) => combineValidations([() => isNotEmpty(value), () => isValidDecimal(value?.removeCurrencyFormat())]),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveAccountBalance();
                  }
                },
                text: _account == null ? "Criar conta" : "Salvar",
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: _account != null,
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
    );
  }
}
