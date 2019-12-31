// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    json['beginTime'] as String,
    json['detailId'] as int,
    json['endTime'] as String,
    json['genderName'] as String,
    json['isLeave'] as bool,
    json['isTimeout'] as bool,
    json['phone'] as String,
    json['photo'] as String,
    json['remark'] as String,
    json['rollCallId'] as int,
    json['statusKey'] as int,
    json['statusName'] as String,
    json['studentId'] as int,
    json['studentName'] as String,
    json['studentNo'] as String,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'beginTime': instance.beginTime,
      'detailId': instance.detailId,
      'endTime': instance.endTime,
      'genderName': instance.genderName,
      'isLeave': instance.isLeave,
      'isTimeout': instance.isTimeout,
      'phone': instance.phone,
      'photo': instance.photo,
      'remark': instance.remark,
      'rollCallId': instance.rollCallId,
      'statusKey': instance.statusKey,
      'statusName': instance.statusName,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'studentNo': instance.studentNo,
    };
