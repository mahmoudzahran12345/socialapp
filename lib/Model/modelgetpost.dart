class PostModel {
  late String name;
  late String uId;
  late String image;
  late String datatime;
  late  String text;
  late String postimage;

  PostModel({
    required this.name ,
    required this.uId,
    required this.image,
    required this.datatime,
    required this.text,
    required this.postimage

  });
  PostModel.fromjson(Map<String,dynamic>json){

    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    datatime = json['datatime'];
    text = json['text'];
    postimage = json['postimage'];


  }
  Map<String,dynamic> tomap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'datatime':datatime,
      'text':text,
      'postimage':postimage

    };
  }
}