import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Modules/edit_profile.dart';
import 'package:untitled24/Shared/components.dart';

class SettingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

        var  usermodel = SocialCubit.get(context).model;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 160.0,
                          width: double.infinity,
                          decoration:   BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0)
                              ),
                              image: DecorationImage(image: NetworkImage('${usermodel!.cover}'),
                                fit: BoxFit.cover,

                              )
                          ),

                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child:  CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage('${usermodel.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0,),
                 Text('${usermodel.name}',
                  style: const TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold) ,
                ),
                Text(
                  '${usermodel.bio}',
                  style:Theme.of(context).textTheme.caption ,
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              'Posts',
                              style:Theme.of(context).textTheme.caption ,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '125',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              'photos',
                              style:Theme.of(context).textTheme.caption ,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100K',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              'Followers',
                              style:Theme.of(context).textTheme.caption ,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '534',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              'Following',
                              style:Theme.of(context).textTheme.caption ,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: (){}, child: const Text('Add photo'))),
                    const SizedBox(width: 20.0),
                    OutlinedButton(onPressed: (){
                      navigatto(context,EditProfile());
                    }, child: const Icon(Icons.edit)),


                  ],
                )


              ],
            ),
          ),
        );


  }
}
