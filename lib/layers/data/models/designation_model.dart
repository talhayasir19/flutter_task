import 'package:flutter_api_task_clean_architecture/layers/domain/entity/export.dart';
import 'package:flutter_api_task_clean_architecture/layers/domain/entity/month_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'designation_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DesignationModel extends DesignationEntity {
  DesignationModel({
    required super.abbreviated,
    required super.expanded,
  });
  factory DesignationModel.fromJson(Map<dynamic, dynamic> json) =>
      _$DesignationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationModelToJson(this);
}
