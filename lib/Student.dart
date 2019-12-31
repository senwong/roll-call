import "package:json_annotation/json_annotation.dart";

part 'Student.g.dart';

@JsonSerializable()
class Student {
  String beginTime;
  int detailId;
  String endTime;
  String genderName;
  bool isLeave;
  bool isTimeout;
  String phone;
  String photo;
  String remark;
  int rollCallId;
  int statusKey;
  String statusName;
  int studentId;
  String studentName;
  String studentNo;

  Student(
    this.beginTime,
    this.detailId,
    this.endTime,
    this.genderName,
    this.isLeave,
    this.isTimeout,
    this.phone,
    this.photo,
    this.remark,
    this.rollCallId,
    this.statusKey,
    this.statusName,
    this.studentId,
    this.studentName,
    this.studentNo,
  );

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
