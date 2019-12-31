
import 'package:json_annotation/json_annotation.dart';
import 'Student.dart';
part 'RollCallDetail.g.dart';

@JsonSerializable()
class RollCallDetail {
  int clazzId;
  String clazzName;
  List<Student> students;

  RollCallDetail(this.clazzId, this.clazzName, this.students);


  factory RollCallDetail.fromJson(Map<String, dynamic> json) => _$RollCallDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RollCallDetailToJson(this);
}