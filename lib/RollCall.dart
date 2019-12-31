import 'package:json_annotation/json_annotation.dart';

part 'RollCall.g.dart';

@JsonSerializable()
class RollCall {
  int detailId;
  int rollCallId;
  String rollCallTime;
  int statusKey;
  String statusName;
  String title;
  int typeId;
  String typeName;
  int rollCallNum;
  int leaveNum;
  int normalNum;
  int absenceNum;
  RollCall(this.detailId, this.rollCallId, this.rollCallTime, this.statusKey,
      this.statusName, this.title, this.typeId, this.typeName);


  factory RollCall.fromJson(Map<String, dynamic> json) => _$RollCallFromJson(json);

  Map<String, dynamic> toJson() => _$RollCallToJson(this);

}
