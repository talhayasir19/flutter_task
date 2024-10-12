import 'package:json_annotation/json_annotation.dart';

class WeekDayEntity {
  WeekDayEntity({
    required this.en,
    required this.ar,
  });
  @JsonKey(name: 'en')
  String en;
  @JsonKey(name: 'ar')
  String? ar;
}
