import 'package:flutter_api_task_clean_architecture/layers/domain/entity/date_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/models/export.dart';
part 'date_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DateModel extends DateEntity {
  DateModel({
    required super.date,
    required super.format,
    required super.day,
    required super.year,
    required super.designation,
    required super.holidays,
    super.weekday,
    super.month,
  });

  factory DateModel.fromJson(Map<dynamic, dynamic> json) =>
      _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);
}
