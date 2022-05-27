import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'package:untitled24/Layout/SocialCubit/Cubit/statesocial.dart';
import 'package:untitled24/Model/modelgetpost.dart';


class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:  [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const [
                      Image(
                        image: NetworkImage('https://image.freepik.com/free-photo/young-man-woman-shirts-posing_273609-41274.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('connect with friend',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                      )
                    ],
                  ),
                ),
                ListView.separated(itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  itemCount: SocialCubit.get(context).posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                ),
                SizedBox(height: 8.0,)

              ],
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    ) ;
  }
  Widget buildPostItem(PostModel postModel,context,index)=>Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
                const SizedBox(width: 15.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  [
                          Text('${postModel.name}',style: TextStyle(color: Colors.black,fontSize: 16.0),),
                          SizedBox(width: 5.0,),
                          Icon(Icons.check_circle,color: Colors.blue,size:15.0,)
                        ],
                      ),
                      Text('${postModel.datatime}',style: Theme.of(context).textTheme.caption,)
                    ],
                  ),
                ),
                SizedBox(width: 15.0,),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],

              ),
            ),
             Text(
              '${postModel.text}',
              style: TextStyle(
                  color: Colors.black,
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
              ),
            ),
           /* Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 5.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(onPressed: (){}
                            ,child:Text(
                              '#SoftwareDeveloper',
                              style: TextStyle(
                                  color: Colors.blue
                              ),
                            ) ,

                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6.0),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(onPressed: (){}
                            ,child:Text(
                              '#Mopile Developer ios Android',
                              style: TextStyle(
                                  color: Colors.blue
                              ),
                            ) ,

                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),




                    ]
                ),
              ),
            ),*/
            if(postModel.postimage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(top:15 ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(image: NetworkImage('${postModel.postimage}'),
                      fit: BoxFit.cover,

                    )
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.favorite_border,color: Colors.red,),
                            SizedBox(width: 5.0,),
                            Text(
                                '${SocialCubit.get(context).likes[index]}'
                            )
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.chat_outlined,color: Colors.grey,),
                            SizedBox(width: 5.0,),
                            Text(
                                '0'
                            )
                          ],
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),


                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),
                        ),
                        SizedBox(width: 15.0,),
                        Text('Write Comment',
                          style: Theme.of(context).textTheme.caption
                          ,)
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border,color: Colors.red,),
                      SizedBox(width: 5.0,),
                      Text(
                          'like'
                      )
                    ],
                  ),
                  onTap: (){
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                  },
                ),
                SizedBox(width: 10.0,),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.ios_share,color: Colors.grey,),
                      SizedBox(width: 5.0,),
                      Text(
                          'share'
                      )
                    ],
                  ),
                  onTap: (){

                  },
                ),


              ],
            )

          ],
        ),
      )
  );
}
