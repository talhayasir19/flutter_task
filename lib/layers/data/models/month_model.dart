import 'package:flutter_api_task_clean_architecture/layers/domain/entity/export.dart';
import 'package:flutter_api_task_clean_architecture/layers/domain/entity/month_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'month_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class MonthModel extends MonthEntity {
  MonthModel({
    required super.en,
    required super.number,
  });
  factory MonthModel.fromJson(Map<dynamic, dynamic> json) =>
      _$MonthModelFromJson(json);

  Map<String, dynamic> toJson() => _$MonthModelToJson(this);
}
