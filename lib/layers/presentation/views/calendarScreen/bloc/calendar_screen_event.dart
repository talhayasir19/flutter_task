part of 'calendar_screen_bloc.dart';

@immutable
sealed class CalendarScreenEvent {}

class CalendarScreenDataFetchEvent extends CalendarScreenEvent {}

class CalendarScreenDataFetchCachedDataEvent extends CalendarScreenEvent {}
