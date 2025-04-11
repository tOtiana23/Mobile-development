// history_cubit.dart
import 'package:credit/data_base/DBProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_state.dart';

/// Cubit для управления состоянием истории расчетов
/// Обрабатывает загрузку и удаление расчетов из базы данных
class HistoryCubit extends Cubit<HistoryState> {
  /// Инициализация с начальным состоянием HistoryInitial
  HistoryCubit() : super(HistoryInitial());

  /// Загружает список всех расчетов из базы данных
  /// Изменяет состояние:
  /// HistoryLoading -> HistoryLoaded (при успехе)
  /// HistoryLoading -> HistoryError (при ошибке)
  Future<void> loadCalculations() async {
    try {
      emit(HistoryLoading()); // Переход в состояние загрузки
      final calculations = await DBProvider.instance.getAllCalculations();
      emit(HistoryLoaded(calculations)); // Успешная загрузка с данными
    } catch (e) {
      emit(HistoryError('Ошибка загрузки истории: $e'));
    }
  }

  /// Удаляет расчет по id и обновляет список
  /// Изменяет состояние:
  /// HistoryLoading -> HistoryLoaded (при успехе)
  /// HistoryLoading -> HistoryError (при ошибке)
  Future<void> deleteCalculation(int id) async {
    try {
      emit(HistoryLoading()); // Переход в состояние загрузки
      await DBProvider.instance.deleteCalculation(id); // Удаление из БД
      final calculations = await DBProvider.instance.getAllCalculations();
      emit(HistoryLoaded(calculations)); // Обновленный список после удаления
    } catch (e) {
      emit(HistoryError('Ошибка удаления: $e'));
    }
  }
}