/// Абстрактный базовый класс для всех состояний экрана истории расчетов
abstract class HistoryState {}

/// Начальное состояние - когда экран только открыли, но еще не начали загрузку данных
/// Используется для инициализации экрана
class HistoryInitial extends HistoryState {}

/// Состояние загрузки данных - когда отправлен запрос на получение истории, но ответ еще не получен
class HistoryLoading extends HistoryState {}

/// Состояние успешной загрузки данных
/// Содержит список расчетов в виде List<Map> где каждый Map содержит:
/// - id: идентификатор записи
/// - capital: начальный капитал
/// - period: срок
/// - rate: процентная ставка  
/// - result: результат расчета
/// - timestamp: дата и время расчета
class HistoryLoaded extends HistoryState {
  final List<Map<String, dynamic>> calculations;

  HistoryLoaded(this.calculations);
}

/// Состояние ошибки при работе с историей расчетов
/// Содержит текстовое сообщение об ошибке для показа пользователю
class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}

/// Состояние, сигнализирующее об успешном удалении записи
class HistoryDeleted extends HistoryState {}