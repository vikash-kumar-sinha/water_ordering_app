import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/checkuser.dart';
import 'package:water_ordering_app/history.dart';
import 'package:water_ordering_app/login.dart';
import 'registration.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Ordering App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: checkUser.id,
      routes: {

        checkUser.id:(context)=>const checkUser(),
        login_page.id:(context)=>const login_page(),
        registration_page.id:(context)=>const registration_page(),

        OrderHistory.id:(context)=>const OrderHistory()
      },
    );
  }
}


