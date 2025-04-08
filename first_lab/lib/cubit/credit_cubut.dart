import 'package:first_lab/cubit/credit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreditCubit extends Cubit<CreditState> {
  CreditCubit() : super(CreditInitial());

  void calculate(double capital, double period, double rate) {
    try {
      final result = capital * (1 + rate / 100 * period);
      
      emit(CreditCalculated(
        capital: capital,
        period: period,
        rate: rate,
        result: result,
      ));
    } catch (e) {
      emit(CreditError('Ошибка расчета: $e'));
    }
  }

  void reset() {
    emit(CreditInitial());
  }
}