import 'package:json_annotation/json_annotation.dart';

import '../../data/models/export.dart';

class CalendarDataEntity {
  CalendarDataEntity({required this.gregorian, required this.hijri});

  DateModel hijri;
  DateModel gregorian;
}
