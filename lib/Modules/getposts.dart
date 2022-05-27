import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';

class GetPostScreen extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();

var textcontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var image = SocialCubit.get(context).postimage  ;
    var  usermodel = SocialCubit.get(context).model;


    return BlocConsumer<SocialCubit,SocialState>(
      listener:(context,state){} ,
      builder:(context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: const Text(
              'Create Post',style: TextStyle(color: Colors.black,),
            ),
            actions: [
              TextButton(onPressed: (){
                var now = DateTime.now();
                if(SocialCubit.get(context).postimage==null){
                  SocialCubit.get(context).createPost(datatime: now.toString(), text: textcontroller.text);
                }else{
                  SocialCubit.get(context).uploadPostImage(datatime: now.toString(), text: textcontroller.text);

                }

              }, child: const Text('post',style: TextStyle(color: Colors.blue,fontSize: 20.0),))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoading)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoading)
                  const SizedBox(height: 10.0),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://image.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg'),
                    ),
                    const SizedBox(width: 15.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Mahmoud Zahran',style: TextStyle(color: Colors.black,fontSize: 16.0),),

                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                        hintText: 'what is on your mind',
                      border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postimage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration:   BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(image:image == null
                                ? NetworkImage('${usermodel!.image}')
                                : FileImage(image)as ImageProvider,
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
                              SocialCubit.get(context).deletePost();
                            },
                                icon: const Icon(Icons.close,size: 16.0,color: Colors.white,))),
                      )
                    ],
                  ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage(ImageSource.camera);
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.camera_alt,color: Colors.blue,
                          ),
                          SizedBox(width: 10.0),
                          Text('Add Photo',style: TextStyle(color: Colors.blue),)
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.tag_faces,color: Colors.blue,
                          ),
                          SizedBox(width: 5.0),
                          Text('#tags',style: TextStyle(color: Colors.blue),)
                        ],
                      )),
                    )


                  ],
                )
              ],
            ),
          ),
        );
      } ,
    );
  }
}
