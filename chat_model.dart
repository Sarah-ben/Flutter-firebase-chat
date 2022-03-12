class ChatModel{
  late String senderID;
  late String receiverID;
  late String dateTime;
  late String text;

  ChatModel({
    required this.senderID,
    required this.receiverID,
    required this.dateTime,
    required this.text,
    });

  ChatModel.fromJson(Map<String,dynamic>?json){
    senderID=json!['senderID'];
    receiverID=json['receiverID'];
    dateTime=json['dateTime'];
    text=json['text'];
  }

  Map<String,dynamic>toMap(){
    return {
      'senderID':senderID,
      'receiverID':receiverID,
      'dateTime':dateTime,
      'text':text,
    };
  }
}