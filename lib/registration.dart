
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
    if(name=="") {
      UiHelper.customAlertBox(context, "Please enter your name");
    } else if(email=="")
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const login_page()));
            _saveProfile(userId: email,name: nameController.text.toString(),phone: phoneController.text.toString(),email: email);
            return null;
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
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        _isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading?const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
      ),
    ):Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Create a new account',style: TextStyle(
            fontFamily: 'heading',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(

              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(flex:3,child: SizedBox()),

                const Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: nameController,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        fontFamily: 'salsa'
                      ),

                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'salsa'
                          ),
                          prefixIcon: const Icon(Icons.person,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'E-mail',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'salsa',
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: const Icon(Icons.email,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: phoneController,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Phone',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'salsa',
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: const Icon(Icons.phone,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: passworrdController,
                      obscureText: true,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold
                      ),

                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'salsa',
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: const Icon(Icons.lock,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                //SizedBox(height: 10,),
                Expanded(flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: confirmPassworrdController,
                      obscureText: _confirmPassObcure,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'salsa'
                      ),

                      decoration: InputDecoration(
                        suffixIcon: IconButton(icon: Icon(_confirmPassObcure?Icons.visibility_off:Icons.visibility),onPressed: (){
                          setState(() {
                            _confirmPassObcure=!_confirmPassObcure;
                          });
                        },),

                          hintText: 'Confirm Password',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'salsa',
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          prefixIcon: const Icon(Icons.lock,color: Colors.blue,),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3.0
                            ),


                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black
                              )
                          )
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                //SizedBox(height: 30,),
                Expanded(flex:4 ,

                  child: SizedBox(
                    height: 40,
                    width: 190,
                    child: TextButton(onPressed: (){registerFunction(nameController.text.toString(),emailController.text.toString(),
                        phoneController.text.toString(), passworrdController.text.toString(),
                        confirmPassworrdController.text.toString());},
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),

                        ), child: const Text('Create account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        fontFamily: 'heading'
                      ),),),
                  ),
                ),
                const Gap(10),

                Expanded(flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have a account?',style: TextStyle(
                          fontSize: 14,
                        fontFamily: 'solway'
                      ),),
                      TextButton(onPressed: (){
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>login_page()));
                        Navigator.pop(context);
                      }, child: const Text('Login',style: TextStyle(
                          fontSize: 15, fontFamily: 'salsa'
                      ),))
                    ],),
                ),
                const Gap(5)

              ],
            ),
          ),
        ),
      ),

    );
  }
}


