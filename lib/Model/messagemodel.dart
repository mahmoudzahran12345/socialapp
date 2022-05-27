class MessageModel {
  late String datatime;
  late String senderId;
  late String recevierId;
  late String text;
  MessageModel({
    required this.datatime ,
    required this.senderId,
    required this.recevierId,
    required this.text,
  });
  MessageModel.fromjson(Map<String,dynamic>json){
    senderId = json['senderId'];
    datatime = json['datatime'];
    recevierId = json['recevierId'];
    text = json['text'];

  }
  Map<String,dynamic> tomap(){
    return {
      'datatime':datatime,
      'senderId':senderId,
      'recevierId':recevierId,
      'text':text,

    };
  }
}