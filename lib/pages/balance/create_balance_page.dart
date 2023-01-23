import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/extensions.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/common/utils.dart';
import 'package:meu_patrimonio/data/model/account_balance.dart';
import 'package:meu_patrimonio/data/repository/account_balance_repository.dart';
import 'package:meu_patrimonio/widgets/buttons.dart';

class CreateBalancePage extends StatefulWidget {
  const CreateBalancePage({Key? key, this.account}) : super(key: key);

  final AccountBalance? account;

  @override
  State<CreateBalancePage> createState() => _CreateBalancePageState();
}

class _CreateBalancePageState extends State<CreateBalancePage> with FormValidator {
  final _formKey = GlobalKey<FormState>();
  final _repository = AccountBalanceRepository();

  AccountBalance? _account;

  final _accountNameTextController = TextEditingController();
  final _balanceTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _account = widget.account;
    _balanceTextController.text = formatToCurrency(widget.account?.balance);
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text("Excluir ${_account?.name}?"),
              content: Text("Deseja realmente excluir permanentemente a conta ${_account?.name}"),
              actions: [
                TextButton(
                  onPressed: (() => Navigator.pop(context)),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _repository.delete(_account!.id).then((value) => Navigator.pop(context));
                    },
                    child: const Text('Sim'))
              ],
            )));
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
                  decoration: const InputDecoration(
                    labelText: "Conta",
                    border: OutlineInputBorder(),
                  ),
                  validator: _account == null ? isNotEmpty : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _balanceTextController,
                inputFormatters: [currencyInputFormatter],
                decoration: const InputDecoration(
                  labelText: "Saldo",
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) => combineValidations([
                  () => isNotEmpty(value),
                  () => isValidDecimal(value?.removeCurrencyFormat()),
                ]),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_account == null) {
                      _repository
                          .createBalance(_accountNameTextController.text, double.parse(_balanceTextController.text.removeCurrencyFormat()))
                          .then((value) => Navigator.pop(context));
                    } else {
                      _repository
                          .editBalance(_account!.id, double.parse(_balanceTextController.text.removeCurrencyFormat()))
                          .then((value) => Navigator.pop(context));
                    }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
