import 'package:flutter_api_task_clean_architecture/layers/domain/entity/export.dart';
import 'package:json_annotation/json_annotation.dart';
part 'week_day_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class WeekDayModel extends WeekDayEntity {
  WeekDayModel({
    required super.en,
    required super.ar,
  });
  factory WeekDayModel.fromJson(Map<dynamic, dynamic> json) =>
      _$WeekDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeekDayModelToJson(this);
}
