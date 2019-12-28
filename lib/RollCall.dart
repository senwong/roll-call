
class RollCall {
  int detailId;
  int rollCallId;
  String rollCallTime;
  int statusKey;
  String statusName;
  String title;
  int typeId;
  String typeName;
  RollCall(this.detailId, this.rollCallId, this.rollCallTime, this.statusKey,
      this.statusName, this.title, this.typeId, this.typeName);

  RollCall.fromJson(Map<String, dynamic> json)
      : detailId = json['detailId'],
        rollCallId = json['rollCallId'],
        rollCallTime = json['rollCallTime'],
        statusKey = json['statusKey'],
        statusName = json['statusName'],
        title = json['title'],
        typeId = json['typeId'],
        typeName = json['typeName'];

  Map<String, dynamic> toJson() => {
        'detailId': detailId,
        'rollCallId': rollCallId,
        'rollCallTime': rollCallTime,
        'statusKey': statusKey,
        'statusName': statusName,
        'title': title,
        'typeId': typeId,
        'typeName': typeName,
      };
}
