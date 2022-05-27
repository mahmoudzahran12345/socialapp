import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialCubit/registerstate.dart';
import 'package:untitled24/Model/modelsocialapp.dart';

class CubitRegister extends Cubit<SocialRegister>{
  CubitRegister() : super (SocialRegisterInatialState());
  static CubitRegister get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })async{
    emit(SocialRegisterLoadingState());
   await FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email,
        password: password
    )
        .then((value) {

      createUser(name: name, email: email, phone: phone, uId: value.user!.uid);

    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });

  }

  void createUser({required String name,required String email,required String phone,required String uId}){
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        IsEmailVerified: false,
        bio: 'Write your self',
        cover: 'https://image.freepik.com/free-photo/handsome-young-european-man-with-bristle-points-upper-right-corner-with-fore-finger_273609-17208.jpg',
        image: 'https://image.freepik.com/free-photo/handsome-young-european-man-with-bristle-points-upper-right-corner-with-fore-finger_273609-17208.jpg',
    );
    FirebaseFirestore.instance.collection('Users').doc(uId).set(model.tomap()).then((value) {
      emit(SocialCreateSuccessfulState());

    }).catchError((error){
      emit(SocialCreateErrorState(error));
    });
  }

  IconData suffix = Icons.visibility;
  bool ispassword = true;
  void changeiconspassword(){
    ispassword = !ispassword;
    suffix = ispassword ?Icons.visibility:Icons.visibility_off;
    emit(changepasswordRegister());
  }

}