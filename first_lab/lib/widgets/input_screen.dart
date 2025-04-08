import 'package:first_lab/cubit/credit_cubut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _agreement = false;
  final _capitalController = TextEditingController();
  final _periodController = TextEditingController();
  final _rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Исходный капитал'),
                validator: _validateField,
              ),
              TextFormField(
                controller: _periodController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Срок (лет)'),
                validator: _validateField,
              ),
              TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ставка (%)'),
                validator: _validateField,
              ),
              CheckboxListTile(
                value: _agreement,
                onChanged: (value) => setState(() => _agreement = value ?? false),
                title: const Text('Согласен на обработку данных'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _agreement) {
                    final capital = double.parse(_capitalController.text);
                    final period = double.parse(_periodController.text);
                    final rate = double.parse(_rateController.text);

                    context.read<CreditCubit>().calculate(capital, period, rate);
                  } else if (!_agreement) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Необходимо согласие'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: const Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) return 'Поле не может быть пустым';
    final number = double.tryParse(value);
    if (number == null || number < 0) return 'Введите корректное положительное число';
    return null;
  }
}
