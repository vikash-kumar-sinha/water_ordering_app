import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:water_ordering_app/login.dart';
import 'package:water_ordering_app/orderList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registration_page extends StatefulWidget {
  static const String id='registrstion_page';
  const registration_page({super.key});

  @override
  State<registration_page> createState() => _registration_pageState();
}

class _registration_pageState extends State<registration_page> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passworrdController=TextEditingController();
  TextEditingController confirmPassworrdController=TextEditingController();
  //String orderId='10001';

  bool _confirmPassObcure=true;
  bool _isLoading=true;

  registerFunction(String name,String email,String phone,String password,String confirmPassword)async{
    if(name=="")
      UiHelper.customAlertBox(context, "Please enter your name");
    else if(email=="")
      UiHelper.customAlertBox(context, "Please enter your email");
    else if(phone=="")
      UiHelper.customAlertBox(context, "Please enter your phone number");
    else if(password=="")
      UiHelper.customAlertBox(context, "Please enter password");
    else if(password!=confirmPassword)
      UiHelper.customAlertBox(context, "Password and confirm password does not match");
    else
      {
        UserCredential? userCrediantial;
        try{
          userCrediantial=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>login_page()));
            _saveProfile(userId: email,name: nameController.text.toString(),phone: phoneController.text.toString(),email: email);
          });
        }
        on FirebaseAuthException catch(ex){
          return UiHelper.customAlertBox(context, ex.code.toString());
        }
      }
  }




  final firestore=FirebaseFirestore.instance;
  void _saveProfile(
  {required String userId,required String name,required String phone,required String email}
      )async{


    final userProfileRef=firestore.collection("Users").doc(userId);
    await userProfileRef.set({
      'name':name,
      'phone':phone,
      'email':email
    }).then((value) {
      UiHelper.customAlertBox(context, "User created Successfully, You can login now");
    });

    setState(() {
      emailController.clear();
      phoneController.clear();
      nameController.clear();

    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading?Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
      ),
    ):Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(

              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex:3,child: SizedBox()),
                Expanded(flex: 4,
                  child: Text('Create a new account',textAlign: TextAlign.center,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,

                  ),),
                ),
                Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),

                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: Icon(Icons.person,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: Icon(Icons.email,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: phoneController,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: Icon(Icons.phone,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passworrdController,
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),

                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: confirmPassworrdController,
                      obscureText: _confirmPassObcure,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),

                      decoration: InputDecoration(
                        suffixIcon: IconButton(icon: Icon(_confirmPassObcure?Icons.visibility_off:Icons.visibility),onPressed: (){
                          setState(() {
                            _confirmPassObcure=!_confirmPassObcure;
                          });
                        },),

                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Gap(20),
                //SizedBox(height: 30,),
                Expanded(flex:4 ,

                  child: SizedBox(
                    height: 40,
                    width: 190,
                    child: TextButton(onPressed: (){registerFunction(nameController.text.toString(),emailController.text.toString(),
                        phoneController.text.toString(), passworrdController.text.toString(),
                        confirmPassworrdController.text.toString());}, child: Text('Create account',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),

                        ),),
                  ),
                ),
                Gap(10),

                Expanded(flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have a account?',style: TextStyle(
                          fontSize: 15
                      ),),
                      TextButton(onPressed: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>login_page()));
                        Navigator.pop(context);
                      }, child: Text('Login',style: TextStyle(
                          fontSize: 15
                      ),))
                    ],),
                ),
                Gap(5)

              ],
            ),
          ),
        ),
      ),

    );
  }
}


