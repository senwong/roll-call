// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RollCallDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RollCallDetail _$RollCallDetailFromJson(Map<String, dynamic> json) {
  return RollCallDetail(
    json['clazzId'] as int,
    json['clazzName'] as String,
    (json['students'] as List)
        ?.map((e) =>
            e == null ? null : Student.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RollCallDetailToJson(RollCallDetail instance) =>
    <String, dynamic>{
      'clazzId': instance.clazzId,
      'clazzName': instance.clazzName,
      'students': instance.students,
    };
