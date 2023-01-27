part of 'date_bloc.dart';

@immutable
abstract class DateEvent {
  final String date;

  DateEvent({required this.date});
}

class NewDateEvent extends DateEvent{
  final String date;

  NewDateEvent({required this.date}):super(date: date);
}