// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RollCall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RollCall _$RollCallFromJson(Map<String, dynamic> json) {
  return RollCall(
    json['detailId'] as int,
    json['rollCallId'] as int,
    json['rollCallTime'] as String,
    json['statusKey'] as int,
    json['statusName'] as String,
    json['title'] as String,
    json['typeId'] as int,
    json['typeName'] as String,
  )
    ..rollCallNum = json['rollCallNum'] as int
    ..leaveNum = json['leaveNum'] as int
    ..normalNum = json['normalNum'] as int
    ..absenceNum = json['absenceNum'] as int;
}

Map<String, dynamic> _$RollCallToJson(RollCall instance) => <String, dynamic>{
      'detailId': instance.detailId,
      'rollCallId': instance.rollCallId,
      'rollCallTime': instance.rollCallTime,
      'statusKey': instance.statusKey,
      'statusName': instance.statusName,
      'title': instance.title,
      'typeId': instance.typeId,
      'typeName': instance.typeName,
      'rollCallNum': instance.rollCallNum,
      'leaveNum': instance.leaveNum,
      'normalNum': instance.normalNum,
      'absenceNum': instance.absenceNum,
    };
