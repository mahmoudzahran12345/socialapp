
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Model/messagemodel.dart';
import 'package:untitled24/Model/modelsocialapp.dart';
import 'package:untitled24/Shared/components.dart';

import 'getposts.dart';

class ChatDetails extends StatelessWidget {
  var textcontroller = TextEditingController();
SocialUserModel userModel;

ChatDetails(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit,SocialState>(
          listener: (context,state){},
          builder: (context,state){
            print(SocialCubit.get(context).message.length);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0.0,
                titleSpacing: 0.0,
                title: Row(
                  children:  [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(width: 15.0,),
                    InkWell(
                      onTap: (){
                        navigatto(context, GetPostScreen());
                      },
                      child: Text(
                        userModel.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition:true ,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var message1 = SocialCubit.get(context).message[index];
                              if(SocialCubit.get(context).model!.uId == message1.senderId) {
                                return buildMyMessage(message1);
                              }else {
                                return buildMessage(message1);
                              }
                            },
                            separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                            itemCount: SocialCubit.get(context).message.length),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.0
                            ),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textcontroller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type you message',

                                ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dataTime: DateTime.now().toString(),
                                      text: textcontroller.text
                                  );
                                },
                                minWidth: 1,
                                child: Icon(Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback:(context)=> const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }
    );
  }
  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )
      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
          model.text
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )
      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
          model.text
      ),
    ),
  );


}
