import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled24/Layout/SocialApp/social_layout.dart';
import 'Layout/SocialCubit/Cubit/cubitsocial.dart';
import 'Modules/edit_profile.dart';
import 'Modules/login.dart';
import 'Shared/cashhelper.dart';
import 'Shared/classobserve.dart';
import 'Shared/constant.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  await CashHelper.init();
  Widget widget;
  uId = CashHelper.getdata12(key: 'uId');
  if(uId !=null){
    print(uId);
    widget = sociallayout();
  }
  else{
    widget = LoginSocial();
  }

  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp(this.startwidget); //
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUser()..getPosts()),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark
              )
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            //backgroundColor: HexColor('333739')
          ),
        ),
        home:LoginSocial(),
      ),
    );
  }
}

