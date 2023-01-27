part of 'date_bloc.dart';

@immutable
abstract class DateState {
  final String date;

  DateState({required this.date});
}

class DateInitial extends DateState {
  DateInitial({required String currentDate}) : super(date: currentDate);
}

class MyDateState extends DateState{
  MyDateState({required String date}):super(date: date);

}
