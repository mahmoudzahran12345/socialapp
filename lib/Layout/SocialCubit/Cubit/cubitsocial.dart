import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Model/messagemodel.dart';
import 'package:untitled24/Model/modelgetpost.dart';
import 'package:untitled24/Model/modelsocialapp.dart';
import 'package:untitled24/Modules/chats.dart';
import 'package:untitled24/Modules/feeds.dart';
import 'package:untitled24/Modules/getposts.dart';
import 'package:untitled24/Modules/setting.dart';
import 'package:untitled24/Modules/user.dart';
import 'package:untitled24/Shared/components.dart';
import 'package:untitled24/Shared/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState>

{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel ?model;
   void getUser(){
     emit(SocialLoadingStateGet());
     FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
       Map<String, dynamic>?name = value.data();
        model = SocialUserModel.fromjson(name!);
         print(value.data());
         emit(SocialGetUserSuccessState());
     }).catchError((error){
       print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
     });

   }
   int currentindex = 0;
   List<Widget>screen = [
     FeedsScreen(),
     ChatsScreen(),
     GetPostScreen(),
     UserScreen(),
     SettingScreen()
   ];
  List<String>title = [
    'Home',
    'Chats',
    'post',
    'User',
    'settings'
  ];
   void changeNavigtionBar(int index){
     if(index==1){
       getAllUsers();
     }
     if(index==2){
       emit(changeGetsPost());
     }
     else{
       currentindex = index;
       emit(changeNavigationBar());

     }
   }
  File ?profileimage;
  File?coverimage;
  String profileUrl ='';
  Future getprofileimage(ImageSource imageSource)async {
    var pickerfile = await ImagePicker().pickImage(source: imageSource);
    if(pickerfile !=null){
      profileimage = File(pickerfile.path);
      emit(changeCoverImagesuccess());
    }
    else{
      emit(changeCoverImageerror());
    }
  }
  //Function get profile
  //////////////////////////////////////
  Future getCoverimage(ImageSource imageSource)async {
    var pickerfile = await ImagePicker().pickImage(source: imageSource);
    if(pickerfile !=null){
      coverimage = File(pickerfile.path);
      emit(changeImagesuccess());
    }
    else{
      emit(changeImageerror());
    }
  }
  //function get coverimage
  /////////////////////////////////////////////
  void uploadImage({
    required String name,
    required String phone,
    required String bio
}){
    emit(loadingimage());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('Users/${Uri.file(profileimage!.path).pathSegments.last}').putFile(profileimage!).then((value) {
      value.ref.getDownloadURL()
          .then((value) {
            //emit(UploadImagesusses());
     print(value);
     updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error){
        emit(UploadImageerror());
      });

    }).catchError((error){});
    emit(UploadImageerror());

  } // Function Upload Image
////////////////////////////////////////////
  void uploadconerImage({
    required String name,
    required String phone,
    required String bio
}){
    emit(loadingimage());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('Users/${Uri.file(coverimage!.path).pathSegments.last}').putFile(coverimage!).then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        //emit(UploadImagecoversusses());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error){
        emit(UploadImagecovererror());
      });

    }).catchError((error){});
    emit(UploadImagecovererror());
  }
  // Function Upload coverimage
  /////////////////////////////////////
  void updateUser({
  required String name,
  required String phone,
  required String bio,
    String? cover,
    String? image
}){
      SocialUserModel Usermodel = SocialUserModel(
        name: name,
        phone: phone,
        uId: model!.uId,
        IsEmailVerified: false,
        bio: bio,
        cover:cover??model!.cover ,
        image: image??model!.image,
        email: model!.email,
      );
      FirebaseFirestore.instance.collection('Users').doc(model!.uId).update(Usermodel.tomap()).
      then((value) {
        getUser();
      }).catchError((error){
         emit(updateusererror());
      });
    }
    //FUnction UpdateUser
///////////////////////////////
  File? postimage;
  Future getPostImage(ImageSource imageSource)async {
    var pickerfile = await ImagePicker().pickImage(source: imageSource);
    if(pickerfile !=null){
      postimage = File(pickerfile.path);
      emit(SocialGetImagePickerSuccess());
    }
    else{
      emit(SocialGetImagePickerError());
    }
  }
  //Function get PostImage
  ////////////////
  void uploadPostImage({
    required String datatime,
    required String text
  }){
    emit(SocialCreatePostLoading());
    firebase_storage.FirebaseStorage.instance.
    ref().
    child('Posts/${Uri.file(postimage!.path).pathSegments.last}').putFile(postimage!).then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        createPost(datatime: datatime, text: text,postimage: value);

      }).catchError((error){
        emit(SocialCreatePostError());
      });

    }).catchError((error){});
    emit(SocialCreatePostError());

  }
  //Function Upload ImagePost
  /////////////////////////////////
  void createPost({

    required String datatime,
    required String text,
     String? postimage
  }){
    emit(SocialCreatePostLoading());

    PostModel Usermodel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      datatime: datatime,
      text: text,
      postimage: postimage??'',


    );
    FirebaseFirestore.instance.collection('Posts').add(Usermodel.tomap()).
    then((value) {
      emit(SocialCreatePostSuccess());
    }).catchError((error){
      emit(SocialCreatePostError());
    });
  }
  // Function CreatePost
//////////////////////////////////
  void deletePost(){
    postimage = null;
    emit(SocialDeletePostImage());
  }
  //Function delete Post
  ///////////////////////////
List <PostModel>posts = [];
  List <String>postsId = [];
  List <int>likes = [];
  void getPosts(){
     FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
        }).catchError((error){});

      });
     }).catchError((erroe){
       emit(SocialGetPostError(erroe.toString()));

     });
 }
 //Function get post
 /////////////////////
 void likePost(String postUId){
   FirebaseFirestore.instance.collection('Posts').doc(postUId).collection('likes').doc(model!.uId).set({'like':true}).then((value) {
    emit(SocialGetLikeSuccess());
   }).catchError((error){
  emit(SocialGetLikeError(error));
   });
 }
 // Function like post
  /////////////////////////////////
   List<SocialUserModel>users = [];
  void getAllUsers(){
    if(users.length==0) {

      FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId']!=model!.uId) {
          users.add(SocialUserModel.fromjson(element.data()));
        }
        emit(SocialGetAllUsersSuccess());

      });
    }).catchError((erreor){
      emit(SocialGetAllUsersError(erreor.toString()));

    });
    }
  }
  //Function get users
 //////////////////////////////////////////
void sendMessage({
  required String receiverId,
  required String dataTime,
  required String text
}){
     MessageModel messageModel = MessageModel(
       text: text,
       datatime: dataTime,
       recevierId: receiverId,
       senderId: model!.uId
     );
     FirebaseFirestore.instance.collection('Users')
         .doc(model!.uId)
         .collection('chats')
         .doc(receiverId)
         .collection('messages')
         .add(messageModel.tomap()).then((value) {
           emit(SocialSendMessageSuccess());
     }).catchError((error){
       emit(SocialSendMessageError(error.toString()));
     });
     FirebaseFirestore.instance.collection('Users')
         .doc(receiverId)
         .collection('chats')
         .doc(model!.uId)
         .collection('messages')
         .add(messageModel.tomap()).then((value) {
       emit(SocialSendMessageSuccess());
     }).catchError((error){
       emit(SocialSendMessageError(error.toString()));
     });
}
// Function send message
List<MessageModel>message = [];
  void getMessage({required String receiverId,}){
    FirebaseFirestore.instance.collection('Users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('datatime')
        .snapshots()
        .listen((event) {
          message=[];
          event.docs.forEach((element) {
            message.add(MessageModel.fromjson(element.data()));
          });
          emit(SocialGetMessageSuccess());

    });
  }
  // function get nessage


}