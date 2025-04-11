import 'package:credit/cubit/credit_cubit/credit_cubut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Виджет для ввода данных
class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // Ключ для управления состоянием формы
  final _formKey = GlobalKey<FormState>();

  // Флаг согласия на обработку данных
  bool _agreement = false;

  // Контроллеры для полей ввода
  final _capitalController = TextEditingController(); // Для исходного капитала
  final _periodController = TextEditingController(); // Для срока в годах
  final _rateController = TextEditingController(); // Для процентной ставки

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Поле ввода исходного капитала
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Исходный капитал',
                ),
                validator: _validateField,
              ),
              // Поле ввода срока
              TextFormField(
                controller: _periodController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Срок (лет)'),
                validator: _validateField,
              ),
              // Поле ввода процентной ставки
              TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ставка (%)'),
                validator: _validateField,
              ),
              // Чекбокс согласия на обработку данных
              CheckboxListTile(
                value: _agreement,
                onChanged:
                    (value) => setState(() => _agreement = value ?? false),
                title: const Text('Согласен на обработку данных'),
              ),
              const SizedBox(height: 20),
              // Кнопка расчета
              ElevatedButton(
                onPressed: () {
                  // Проверяем валидность формы и наличие согласия
                  if (_formKey.currentState!.validate() && _agreement) {
                    // Парсим введенные значения
                    final capital = double.parse(_capitalController.text);
                    final period = double.parse(_periodController.text);
                    final rate = double.parse(_rateController.text);
                    // Вызываем расчет через Cubit
                    context.read<CreditCubit>().calculate(
                      capital,
                      period,
                      rate,
                    );
                  } else if (!_agreement) {
                    // Показываем ошибку если нет согласия
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

  /// Валидатор для полей ввода
  /// Проверяет что:
  /// 1. Поле не пустое
  /// 2. Введено корректное число
  /// 3. Число положительное
  String? _validateField(String? value) {
    if (value == null || value.isEmpty) return 'Поле не может быть пустым';
    final number = double.tryParse(value);
    if (number == null || number < 0)
      return 'Введите корректное положительное число';
    return null;
  }
}
