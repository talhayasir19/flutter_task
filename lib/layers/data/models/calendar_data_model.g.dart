// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarDataModel _$CalendarDataModelFromJson(Map<dynamic, dynamic> json) =>
    CalendarDataModel(
      gregorian: DateModel.fromJson(json['gregorian'] as Map<dynamic, dynamic>),
      hijri: DateModel.fromJson(json['hijri'] as Map<dynamic, dynamic>),
    );

Map<String, dynamic> _$CalendarDataModelToJson(CalendarDataModel instance) =>
    <String, dynamic>{
      'hijri': instance.hijri.toJson(),
      'gregorian': instance.gregorian.toJson(),
    };
