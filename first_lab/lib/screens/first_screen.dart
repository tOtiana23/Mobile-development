import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _agreement = false;

  final _capitalController = TextEditingController();
  final _periodController = TextEditingController();
  final _rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бусыгина Татьяна')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _capitalController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Исходный капитал',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите исходный капитал';
                    }

                    if (double.tryParse(value) == null) {
                      return 'Введите корректное число';
                    }

                    if (double.parse(value) < 0) {
                      return 'Число не может быть отрицательным';
                    }

                    return null;
                  },
                ),

                TextFormField(
                  controller: _periodController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Срок начисления процентов (лет)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите срок начисления процентов';
                    }

                    if (double.tryParse(value) == null) {
                      return 'Введите корректное число';
                    }

                    if (double.parse(value) < 0) {
                      return 'Число не может быть отрицательным';
                    }

                    return null;
                  },
                ),

                TextFormField(
                  controller: _rateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ставка процентов',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите ставку процентов';
                    }

                    if (double.tryParse(value) == 0) {
                      return 'Введите корректное число';
                    }

                    if (double.parse(value) < 0) {
                      return 'Число не может быть отрицательным';
                    }

                    return null;
                  },
                ),

                CheckboxListTile(
                  value: _agreement,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreement = value ?? false;
                    });
                  },
                  title: const Text('Я согласен на обработку данных'),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agreement) {
                        Navigator.pushNamed(
                          context,
                          '/second',
                          arguments: {
                            'capital': double.parse(_capitalController.text),
                            'period': double.parse(_periodController.text),
                            'rate': double.parse(_rateController.text),
                          },
                        );
                      } else if (!_agreement) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Необходимо дать согласие на обработку данных',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color.fromARGB(255, 252, 158, 172),
                          ),
                        );
                      }
                    },
                    child: const Text('Рассчитать'),
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
