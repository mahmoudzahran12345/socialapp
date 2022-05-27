
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialApp/social_layout.dart';
import 'package:untitled24/Layout/SocialCubit/registercubit.dart';
import 'package:untitled24/Layout/SocialCubit/registerstate.dart';
import 'package:untitled24/Shared/components.dart';



class RegisterScreen extends StatelessWidget {

  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formkey2 = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context)=> CubitRegister(),
      child: BlocConsumer<CubitRegister,SocialRegister>(
        listener: (context,state){
          if(state is SocialCreateSuccessfulState){
            navigatandfinsh(context,sociallayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldkey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.blue),
              title: const Center(child: Text('Register',style: TextStyle(color: Colors.blue,fontSize: 25.0,fontWeight: FontWeight.bold),)),

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey2,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.0,),
                        TextFormField(
                          decoration:   InputDecoration(
                              labelText: ' Enter Name',
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ) ,
                              prefixIcon:  const Icon(Icons.person,),
                              labelStyle:  const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,


                              )
                          ),
                          keyboardType:TextInputType.emailAddress ,

                          controller: namecontroller,
                          validator: (String ?value){
                            if(value!.isEmpty)
                            {
                              return 'Please Enter the Name';
                            }
                            return null;
                          },


                        ),
                        const SizedBox(height: 30.0,),
                        TextFormField(

                          decoration:   InputDecoration(
                              labelText: ' Enter Email',
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ) ,
                              prefixIcon:  const Icon(Icons.email,),
                              labelStyle:  const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,


                              )
                          ),
                          keyboardType:TextInputType.emailAddress ,

                          controller: emailcontroller,
                          validator: (String ?value){
                            if(value!.isEmpty)
                            {
                              return 'Please Enter the Email';
                            }
                            return null;
                          },


                        ),
                        const SizedBox(height: 30.0,),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: CubitRegister.get(context).ispassword,
                          decoration:InputDecoration(
                              labelText: 'Enter Password',
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ) ,
                              prefixIcon:const Icon(
                                  Icons.lock
                              ) ,
                              suffixIcon: IconButton(onPressed: (){
                                CubitRegister.get(context).changeiconspassword();
                              },icon: Icon(CubitRegister.get(context).suffix),),
                              labelStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )

                          ) ,
                          keyboardType:TextInputType.visiblePassword ,

                          validator: (String ?value){
                            if(value!.isEmpty){
                              return 'please enter the password';
                            }
                            return null;
                          },


                        ),

                        const SizedBox(height: 30.0,),
                        TextFormField(

                          decoration:   InputDecoration(
                              labelText: ' Enter phone',
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ) ,
                              prefixIcon:  const Icon(Icons.phone_android,),
                              labelStyle:  const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,


                              )
                          ),
                          keyboardType:TextInputType.emailAddress ,

                          controller: phonecontroller,
                          validator: (String ?value){
                            if(value!.isEmpty)
                            {
                              return 'Please Enter the phone';
                            }
                            return null;
                          },


                        ),
                        const SizedBox(height: 25.0,),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ConditionalBuilder(
                            condition:state is!SocialRegisterLoadingState ,
                            builder: (context)=>MaterialButton(
                              color: Colors.greenAccent,
                              minWidth: double.infinity,
                              height: 50.0,

                              onPressed: (){
                                if(formkey2.currentState!.validate())
                                {
                                  CubitRegister.get(context).userRegister(
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      phone: phonecontroller.text
                                  );
                                }
                              }

                              ,

                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black
                                ),
                              ),

                            ),
                            fallback:(context)=> const Center(child: CircularProgressIndicator()),
                          ),
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
