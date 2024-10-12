import 'package:json_annotation/json_annotation.dart';

class DesignationEntity {
  DesignationEntity({
    required this.abbreviated,
    required this.expanded,
  });

  String abbreviated;

  String expanded;
}
