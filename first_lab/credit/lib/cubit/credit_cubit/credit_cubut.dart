import 'package:credit/cubit/credit_cubit/credit_state.dart';
import 'package:credit/data_base/DBProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// Cubit для управления логикой кредитного калькулятора
/// Обрабатывает: расчеты, сохранение в историю, работу с базой данных
class CreditCubit extends Cubit<CreditState> {
  /// Инициализация с начальным состоянием CreditInitial
  CreditCubit() : super(CreditInitial());

  /// Основной метод для расчета кредита
  /// [capital] - начальная сумма
  /// [period] - срок в годах
  /// [rate] - процентная ставка
  Future<void> calculate(double capital, double period, double rate) async {
    try {
      // Простой расчет по формуле
      final result = capital * (1 + rate / 100 * period);

      // Формируем структуру данных для сохранения в БД
      final calculation = {
        DBProvider.columnCapital: capital,     // Сумма
        DBProvider.columnPeriod: period,       // Срок
        DBProvider.columnRate: rate,           // Ставка
        DBProvider.columnResult: result,       // Результат
        DBProvider.columnTimestamp: DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.now()),           // Текущая дата/время
      };

      // Сохраняем расчет в базу данных
      await DBProvider.instance.insertCalculation(calculation);

      // Переходим в состояние с результатами расчета
      emit(CreditCalculated(
        capital: capital,
        period: period,
        rate: rate,
        result: result,
      ));
    } catch (e) {
      // В случае ошибки - переходим в состояние ошибки
      emit(CreditError('Ошибка расчета: $e'));
    }
  }

  /// Получение всей истории расчетов из базы данных
  /// Возвращает List<Map> где каждый Map содержит поля:
  /// id, capital, period, rate, result, timestamp
  Future<List<Map<String, dynamic>>> getHistory() async {
    return await DBProvider.instance.getAllCalculations();
  }

  /// Удаление конкретного расчета по его ID
  Future<void> deleteCalculation(int id) async {
    await DBProvider.instance.deleteCalculation(id);
  }

  /// Сброс в начальное состояние
  void reset() {
    emit(CreditInitial());
  }
}