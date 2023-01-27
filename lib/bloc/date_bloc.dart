import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_event.dart';
part 'date_state.dart';

DateTime current = DateTime.now();

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateInitial(currentDate: current.toString())) {
    on<NewDateEvent>((event, emit) {
      emit(MyDateState(date: event.date));
      // print("bloc dan gelen değer : ${event.date}");
    });
  }
}
