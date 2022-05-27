import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Shared/components.dart';
class EditProfile extends StatelessWidget {
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        var  usermodel = SocialCubit.get(context).model;
        var image = SocialCubit.get(context).profileimage  ;
        var imagecover = SocialCubit.get(context).coverimage  ;
        namecontroller.text=usermodel!.name;
        biocontroller.text=usermodel.bio;
        phonecontroller.text=usermodel.phone;

        return  Scaffold(
          key: scaffoldkey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme:  const IconThemeData(color: Colors.black),
            elevation: 0,
            titleSpacing: 0.0,
            title:  const Text(
              'Edit Profile',style: TextStyle(color: Colors.black,),
            ),
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).updateUser(name: namecontroller.text, phone: phonecontroller.text, bio: biocontroller.text);
              }, child: const Text('UPDATE',style: TextStyle(fontSize: 16.0),))
            ],
          ),
          body: Padding(
            padding:  const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 if(state is loadingimage)
                  const LinearProgressIndicator(),
                  if(state is loadingimage)
                    const SizedBox(height: 10,),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration:   BoxDecoration(
                                    borderRadius:  const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)
                                    ),
                                    image: DecorationImage(image:imagecover ==null? NetworkImage('${usermodel.cover}'):FileImage(imagecover)

                                      as ImageProvider,
                                      fit: BoxFit.cover,

                                    )
                                ),

                              ),
                              Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20.0,
                                    child: IconButton(onPressed: (){
                                      scaffoldkey.currentState!.showBottomSheet((context) => Container(
                                        color: Colors.blueGrey,
                                        width: double.infinity,
                                        height: 150.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              const Text(
                                                'Profile photo',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(height: 20.0),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    child: IconButton(onPressed: (){
                                                      SocialCubit.get(context).getCoverimage(ImageSource.camera);
                                                      Navigator.pop(context);

                                                    }, icon: const Icon(
                                                        Icons.camera_alt
                                                    )),
                                                  ),
                                                  SizedBox(width: 35.0,),
                                                  CircleAvatar(
                                                    child: IconButton(onPressed: (){
                                                      SocialCubit.get(context).getCoverimage(ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    }, icon: const Icon(
                                                        Icons.camera
                                                    )),
                                                  ),


                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                children:  const [
                                                  Text(
                                                    'Cemara',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  SizedBox(width: 30.0,),
                                                  Text(
                                                    'Gallary',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                    },
                                        icon: const Icon(Icons.camera_alt,size: 16.0,color: Colors.white,))),
                              )
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child:  CircleAvatar(
                                radius: 60.0,
                                backgroundImage: image == null
                                    ? NetworkImage('${usermodel.image}')
                                    : FileImage(image)as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20.0,
                                child: IconButton(onPressed: (){
                                  scaffoldkey.currentState!.showBottomSheet((context) => Container(
                                    color: Colors.blueGrey,
                                    width: double.infinity,
                                    height: 150.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          const Text(
                                            'Profile photo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                         Row(
                                           children: [
                                             CircleAvatar(
                                               child: IconButton(onPressed: (){
                                                 SocialCubit.get(context).getprofileimage(ImageSource.camera);
                                                 Navigator.pop(context);

                                               }, icon: const Icon(
                                                   Icons.camera_alt
                                               )),
                                             ),
                                             SizedBox(width: 35.0,),
                                             CircleAvatar(
                                               child: IconButton(onPressed: (){
                                                 SocialCubit.get(context).getprofileimage(ImageSource.gallery);
                                                 Navigator.pop(context);

                                               }, icon: const Icon(
                                                   Icons.camera
                                               )),
                                             ),


                                           ],
                                         ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children:  const [
                                              Text(
                                                'Cemara',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(width: 30.0,),
                                              Text(
                                                'Gallary',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),

                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  ));

                                },
                                    icon: const Icon(Icons.camera_alt,size: 16.0,color: Colors.white,))),

                          ],

                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 25.0,),
                  if(SocialCubit.get(context).profileimage!=null || SocialCubit.get(context).coverimage!=null)
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileimage!=null)
                        Expanded(child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: MaterialButton(onPressed: (){
                                 SocialCubit.get(context).uploadImage(name: namecontroller.text,
                                     phone: phonecontroller.text,
                                     bio: biocontroller.text);
                              },
                              child: const Text('Upload Image'),
                                color: Colors.blue,
                                height: 40.0,
                              ),
                            ),
                            if(state is loadingimage)
                              const SizedBox(height: 5.0,),
                            if(state is loadingimage)
                              const LinearProgressIndicator(),
                          ],
                        )
                        ),
                        const SizedBox(width: 20.0,),
                        if(SocialCubit.get(context).coverimage!=null)
                          Expanded(child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: MaterialButton(onPressed: (){
                                     SocialCubit.get(context).uploadconerImage(name: namecontroller.text,
                                         phone: phonecontroller.text,
                                         bio: biocontroller.text);
                                },
                                  child: const Text('Upload cover'),
                                  color: Colors.blue,
                                  height: 40.0,
                                ),
                              ),
                              if(state is loadingimage)
                                const SizedBox(height: 5.0,),
                              if(state is loadingimage)
                                const LinearProgressIndicator(),
                            ],
                          )
                          ),
                      ],
                    ),
                  const SizedBox(height: 45.0,),
                  TextFormField(
                    decoration:    const InputDecoration(
                        labelText: ' Update Name',
                        border:OutlineInputBorder(

                        ) ,
                        prefixIcon:  Icon(Icons.person,),
                        labelStyle:  TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,


                        )
                    ),
                    keyboardType:TextInputType.name ,

                    controller: namecontroller,
                    validator: (String ?value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter the Name';
                      }
                      return null;
                    },


                  ),
                   const SizedBox(height: 15.0,),
                  TextFormField(
                    decoration:    const InputDecoration(
                        labelText: ' Update bio',
                        border:OutlineInputBorder(

                        ) ,
                        prefixIcon:  Icon(Icons.supervised_user_circle,),
                        labelStyle:  TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,


                        )
                    ),
                    keyboardType:TextInputType.text ,

                    controller: biocontroller,
                    validator: (String ?value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter the bio';
                      }
                      return null;
                    },


                  ),
                  const SizedBox(height: 15.0,),
                  TextFormField(
                    decoration:    const InputDecoration(
                        labelText: ' Update phone',
                        border:OutlineInputBorder(

                        ) ,
                        prefixIcon:  Icon(Icons.phone,),
                        labelStyle:  TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,


                        )
                    ),
                    keyboardType:TextInputType.phone ,

                    controller: phonecontroller,
                    validator: (String ?value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter the phone';
                      }
                      return null;
                    },


                  ),
                ],
              ),

            ),
          ),
        );
      },
    );
  }
}
