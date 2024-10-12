import 'package:json_annotation/json_annotation.dart';

import '../../data/models/export.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DateEntity {
  DateEntity({
    required this.date,
    required this.format,
    required this.day,
    required this.year,
    required this.designation,
    required this.holidays,
    this.weekday,
    this.month,
  });

  String date;
  String format;
  String day;
  WeekDayModel? weekday;
  MonthModel? month;
  String year;
  DesignationModel designation;
  List<dynamic>? holidays;
}
