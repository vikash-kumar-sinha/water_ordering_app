import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:water_ordering_app/dashboard.dart';
import 'package:water_ordering_app/login.dart';

class checkUser extends StatefulWidget {
  static const String id='checkUser';
  const checkUser({super.key});


  @override
  State<checkUser> createState() => _checkUserState();
}

class _checkUserState extends State<checkUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser1();
  }

  checkUser1(){
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      final FirebaseAuth auth=FirebaseAuth.instance;
      final User? user=auth.currentUser;
      final String? currentUserEmail=user?.email;
      return dashboard(currentUserEmail: currentUserEmail,);
    }else {
      return const login_page();
    }
  }
}
