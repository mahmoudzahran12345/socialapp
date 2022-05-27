class SocialUserModel {
  late String name;
   late String email;
   late String phone;
   late String uId;
   late bool IsEmailVerified;
  late String image;
  late String cover;
  late String bio;
SocialUserModel({
      required this.name ,
      required this.email,
      required this.phone,
      required this.uId,
      required this.image,
      required this.bio,
     required this.cover,
      required this.IsEmailVerified
});
SocialUserModel.fromjson(Map<String,dynamic>json){
  email = json['email'];
  name = json['name'];
  phone = json['phone'];
  uId = json['uId'];
  image = json['image'];
  bio = json['bio'];
  cover = json['cover'];
  IsEmailVerified = json['IsEmailVerified'];
}
  Map<String,dynamic> tomap(){
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'uId':uId,
    'IsEmailVerified':IsEmailVerified,
    'image':image,
    'cover':cover,
    'bio':bio,
  };
  }
}