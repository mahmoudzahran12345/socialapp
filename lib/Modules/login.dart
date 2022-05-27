

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:untitled24/Layout/SocialApp/social_layout.dart';
import 'package:untitled24/Layout/SocialCubit/socialcubitlogin.dart';
import 'package:untitled24/Layout/SocialCubit/socialstatelogin.dart';
import 'package:untitled24/Modules/registerscreen.dart';
import 'package:untitled24/Shared/cashhelper.dart';
import 'package:untitled24/Shared/components.dart';

class LoginSocial  extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener:(context,state){
          if(state is SocialLoginErrorState){
            showtoast(text: state.error, state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccessfulState){
            CashHelper.savedata(key: 'uId',
                value: state.uId
            )
                .then((value) {
              navigatandfinsh(context, sociallayout());
            });
          }
          
        } ,
        builder:(context,state){
          return Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                      const SizedBox(height: 40.0,),
                      TextFormField(
                        decoration:   InputDecoration(
                            labelText: '  Email',
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ) ,
                            prefixIcon:  const Icon(Icons.email,),
                            labelStyle:  const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
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
                        obscureText: SocialLoginCubit.get(context).ispassword,
                        decoration:InputDecoration(
                            labelText: 'Password',
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ) ,
                            prefixIcon:const Icon(
                                Icons.lock
                            ) ,
                            suffixIcon: IconButton(onPressed: (){
                              SocialLoginCubit.get(context).ChangeIconsPassword();
                            },icon: Icon(SocialLoginCubit.get(context).suffix),),
                            labelStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){},

                              child: const Text('Forgot Password ?',
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20,),
                      ConditionalBuilder(
                        condition: state is !SocialLoginLoadingState,
                        builder: (context)=>Container(
//color: Colors.blue,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.0),
                              color: Colors.white
                          ),
                          child: MaterialButton(

                            onPressed: (){
                              if(formkey2.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                              }

                            }

                            ,

                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                              ),
                            ),

                          ),
                        ),
                        fallback: (context)=>const Center(child: CircularProgressIndicator()),

                      ),
                      const SizedBox(height: 20,),
                      const Text('- OR -',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20,),
                      const Text('Sign in with',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  color: Colors.white
                              ),
                              child: TextButton(onPressed: (){}, child: Image(image: AssetImage('assets/images/eee.png'),height: 60.0,width: 60.0,))),
                          SizedBox(width: 20.0,),
                          Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  color: Colors.white
                              ),
                              child: TextButton(onPressed: (){}, child: const Image(image: AssetImage('assets/images/rr.png'),height: 60.0,width: 60.0,)))
                        ],
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children:  [
                          const Text('Dont have an Account ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.white),
                          ),
                          const SizedBox(width: 10,),
                          TextButton(onPressed: (){
                            navigatto(context,RegisterScreen());
                          }, child:const Text('Register',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),))
                        ],
                      )







                    ],
                  ),
                ),
              ),
            ),


          );
        } ,

      ),
    );
  }

}
