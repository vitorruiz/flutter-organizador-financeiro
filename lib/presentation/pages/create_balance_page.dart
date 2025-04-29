import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/domain/entities/account_balance.dart';
import 'package:meu_patrimonio/presentation/blocs/account_balance_notifier.dart';
import 'package:meu_patrimonio/presentation/widgets/buttons.dart';

class CreateBalancePage extends ConsumerStatefulWidget {
  const CreateBalancePage({super.key, this.account});

  final AccountBalance? account;

  @override
  ConsumerState<CreateBalancePage> createState() => _CreateBalancePageState();
}

class _CreateBalancePageState extends ConsumerState<CreateBalancePage> with FormValidator {
  final _formKey = GlobalKey<FormState>();
  AccountBalanceNotifier? _accountBalanceNotifier;

  AccountBalance? _account;

  final _accountNameTextController = TextEditingController();
  final _balanceTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _accountBalanceNotifier = ref.read(accountBalanceListProvider.notifier);
    _account = widget.account;
    _balanceTextController.text = formatToCurrency(widget.account?.balance);
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
                  _accountBalanceNotifier?.delete(_account!.id).then((value) => {if (context.mounted) Navigator.pop(context)});
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

    _accountBalanceNotifier?.saveOrUpdate(_account!).then((value) => {if (mounted) Navigator.of(context).pop()});
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
    );
  }
}
