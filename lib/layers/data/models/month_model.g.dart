// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthModel _$MonthModelFromJson(Map<dynamic, dynamic> json) => MonthModel(
      en: json['en'] as String,
      number: (json['number'] as num).toInt(),
    )..ar = json['ar'] as String?;

Map<String, dynamic> _$MonthModelToJson(MonthModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
      'ar': instance.ar,
    };
