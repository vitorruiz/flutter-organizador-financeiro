import 'package:flutter/material.dart';
import 'package:meu_patrimonio/common/form_validator.dart';
import 'package:meu_patrimonio/data/repository/goal_repository.dart';

class CreateGoalPage extends StatefulWidget {
  const CreateGoalPage({Key? key}) : super(key: key);

  @override
  State<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> with FormValidator {
  final _formKey = GlobalKey<FormState>();
  final _repository = GoalRepository();

  final _goalNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nova meta")),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _goalNameTextController,
                decoration: const InputDecoration(
                  labelText: "Meta",
                  border: OutlineInputBorder(),
                ),
                validator: isNotEmpty,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _repository.createGoal(_goalNameTextController.text).then((value) => Navigator.pop(context));
                    }
                  },
                  child: const Text("Criar meta"))
            ],
          ),
        ),
      ),
    );
  }
}
