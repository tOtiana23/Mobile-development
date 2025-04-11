/// Абстрактный базовый класс для всех состояний кредитного калькулятора
/// Наследуясь от него, конкретные состояния определяют возможные варианты состояний в приложении
abstract class CreditState {}

/// Начальное состояние калькулятора - когда пользователь только открыл экран и еще не ввел данные для расчета
class CreditInitial extends CreditState {}

/// Состояние после успешного расчета кредита
/// Содержит все введенные параметры и результат расчета:
/// [capital] - начальная сумма (основной долг)
/// [period] - срок кредита в годах/месяцах
/// [rate] - процентная ставка
/// [result] - итоговая сумма к выплате
class CreditCalculated extends CreditState {
  final double capital;
  final double period;
  final double rate;
  final double result;
  
  CreditCalculated({
    required this.capital,
    required this.period,
    required this.rate,
    required this.result,
  });
}

/// Состояние ошибки при расчете кредита
/// Содержит [message] с описанием ошибки для показа пользователю
class CreditError extends CreditState {
  final String message;

  CreditError(this.message);
}

/// Специальное состояние для запроса обновления истории расчетов
/// Может использоваться для триггеринга обновления списка истории без изменения текущих параметров расчета
class HistoryRefreshRequested extends CreditState {}