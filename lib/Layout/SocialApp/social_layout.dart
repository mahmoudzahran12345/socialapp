import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Modules/getposts.dart';
import 'package:untitled24/Shared/components.dart';

class sociallayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){
        if(state is changeGetsPost){
          navigatto(context,GetPostScreen());
        }
      },
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        return Scaffold(

          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title:  Text(cubit.title[cubit.currentindex],style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notification_important_outlined,color: Colors.black,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.black,))

            ],
          ),
          body: cubit.screen[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeNavigtionBar(index);
            },
            currentIndex: cubit.currentindex,
            items: const [

              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_outlined),label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.upload_file),label: 'AddPost'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'user'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'setting'),

            ],
          ),

        );
      },

    );
  }
}
