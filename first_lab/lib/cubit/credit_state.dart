abstract class CreditState {}

class CreditInitial extends CreditState {}

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

class CreditError extends CreditState {
  final String message;

  CreditError(this.message);
}
