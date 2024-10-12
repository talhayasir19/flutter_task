part of 'calendar_screen_bloc.dart';

@immutable
sealed class CalendarScreenState {}

final class CalendarScreenInitialState extends CalendarScreenState {}

final class CalendarScreenLoadingState extends CalendarScreenState {}

final class CalendarScreenErrorState extends CalendarScreenState {}

final class CalendarScreenNoDataFoundState extends CalendarScreenState {}

final class CalendarScreenLoadedState extends CalendarScreenState {
  final CalendarDataModel? model;
  String lastCached;
  CalendarScreenLoadedState({required this.model, required this.lastCached});
}
