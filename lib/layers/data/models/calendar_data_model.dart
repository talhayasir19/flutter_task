import 'package:json_annotation/json_annotation.dart';

import '../../data/models/export.dart';
import '../../domain/entity/export.dart';
part 'calendar_data_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CalendarDataModel extends CalendarDataEntity {
  CalendarDataModel({required super.gregorian, required super.hijri});

  factory CalendarDataModel.fromJson(Map<dynamic, dynamic> json) =>
      _$CalendarDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarDataModelToJson(this);
}
