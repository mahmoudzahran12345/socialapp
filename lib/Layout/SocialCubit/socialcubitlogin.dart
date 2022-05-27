import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled24/Layout/SocialCubit/registerstate.dart';
import 'package:untitled24/Layout/SocialCubit/socialstatelogin.dart';
import 'dart:io';
import 'package:untitled24/Model/modelsocialapp.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super (SocialLoginInatialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility;
  bool ispassword = true;
  void ChangeIconsPassword(){
    ispassword = !ispassword;
    suffix = ispassword ?Icons.visibility:Icons.visibility_off;
    emit(ChangePassword());
  }
  void userLogin({
    required String email,
    required String password,
  }){
    emit(SocialLoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email
         , password: password
     ).then((value) {

      emit(SocialLoginSuccessfulState(value.user!.uid));

    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });

  }


}