// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateModel _$DateModelFromJson(Map<dynamic, dynamic> json) => DateModel(
      date: json['date'] as String,
      format: json['format'] as String,
      day: json['day'] as String,
      year: json['year'] as String,
      designation: DesignationModel.fromJson(
          json['designation'] as Map<dynamic, dynamic>),
      holidays: json['holidays'] as List<dynamic>?,
      weekday: json['weekday'] == null
          ? null
          : WeekDayModel.fromJson(json['weekday'] as Map<dynamic, dynamic>),
      month: json['month'] == null
          ? null
          : MonthModel.fromJson(json['month'] as Map<dynamic, dynamic>),
    );

Map<String, dynamic> _$DateModelToJson(DateModel instance) => <String, dynamic>{
      'date': instance.date,
      'format': instance.format,
      'day': instance.day,
      'weekday': instance.weekday?.toJson(),
      'month': instance.month?.toJson(),
      'year': instance.year,
      'designation': instance.designation.toJson(),
      'holidays': instance.holidays,
    };
