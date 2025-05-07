import 'package:flutter/material.dart';
import '../utils/calc_history_utils.dart';


// Экран для конвертации единиц скорости (м/с <-> км/ч)
class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  // Контроллеры для текстовых полей ввода
  final TextEditingController _kmhController = TextEditingController();
  final TextEditingController _msController = TextEditingController();

  // Список для хранения истории вычислений 
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Загружаем историю при инициализации
  }

  // Загружает историю вычислений из хранилища
  Future<void> _loadHistory() async {
    final history = await CalcHistoryUtils.loadHistory();
    setState(() {
      _history = history; // Обновляем состояние с загруженной историей
    });
  }

  // Сохраняет новую запись в истории
  Future<void> _saveHistory(String entry) async {
    await CalcHistoryUtils.saveEntry(entry); // Сохраняем в хранилище
    _loadHistory(); // обновим список истории
  }

  // Очищает всю историю вычислений
  Future<void> _clearHistory() async {
    await CalcHistoryUtils.clearHistory(); // Очищаем хранилище
    setState(() {
      _history.clear(); // Очищаем локальный список
    });
  }

  // Конвертирует м/с в км/ч
  void convertToKmH() {
    final msValue = double.tryParse(_msController.text);
    if (msValue != null) {
      final kmhValue = msValue * 3.6; // Формула конвертации
      setState(() {
        _kmhController.text = kmhValue.toStringAsFixed(2); // Округление до 2 знаков
      });
      // Сохрняем в историю
      _saveHistory('${msValue.toStringAsFixed(2)} м/с = ${kmhValue.toStringAsFixed(2)} км/ч');
    }
  }

  // Конвертирует км/ч в м/с
  void convertToMs() {
    final kmhValue = double.tryParse(_kmhController.text);
    if (kmhValue != null) {
      final msValue = kmhValue / 3.6;
      setState(() {
        _msController.text = msValue.toStringAsFixed(2);
      });
      _saveHistory('${kmhValue.toStringAsFixed(2)} км/ч = ${msValue.toStringAsFixed(2)} м/с');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Преобразование скорости"),
        actions: [
          // Кнопка очистки истории
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearHistory,
            tooltip: 'Очистить историю',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Поле ввода км/ч
              TextField(
                controller: _kmhController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Скорость (км/ч)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Кнопка конвертации в м/с
              ElevatedButton(
                onPressed: convertToMs,
                child: const Text("Преобразовать в м/с"),
              ),
              const SizedBox(height: 16),
              // Поле ввода м/с
              TextField(
                controller: _msController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Скорость (м/с)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Кнопка конвертации в км/ч
              ElevatedButton(
                onPressed: convertToKmH,
                child: const Text("Преобразовать в км/ч"),
              ),
              const SizedBox(height: 32),
              const Text(
                'История вычислений:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Список истории вычислений
              ListView.builder(
                shrinkWrap: true,
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(_history[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
