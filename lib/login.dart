import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/dashboard.dart';
import 'package:water_ordering_app/orderList.dart';
import 'package:water_ordering_app/registration.dart';
import 'registration.dart';
import 'forgotPassword.dart';

class login_page extends StatefulWidget {
  static const String id='login_page';
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool _passObcure=true;

  login(String email,String password)async{
    if(email=="" && password=="")
      UiHelper.customAlertBox(context, "Please enter required crediantials");
    else
      {
        UserCredential? userCrediantial;
        try{
          userCrediantial=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
            emailController.clear();
            passwordController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard(currentUserEmail: email)));
          });
        } on FirebaseAuthException catch(ex){
          return UiHelper.customAlertBox(context, ex.code.toString());
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(flex:4,child: SizedBox()),
              Expanded(flex: 7,child: Image.asset('images/logo.png',height: 200.0,width: 200.0,)),

              Expanded(flex: 3,
                child: Text('Welcome back',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),),
              ),
              //SizedBox(height: 30,),
              Expanded(flex: 3,
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
              //SizedBox(height: 10,),
              Expanded(flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(

                    controller: passwordController,
                    obscureText: _passObcure,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_passObcure?Icons.visibility_off:Icons.visibility),onPressed: (){
                          setState(() {
                            _passObcure=!_passObcure;
                          });
                      },
                      ),
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
              Expanded(flex:2,child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPassword()));}, child: Text('Forgot Password?',style: TextStyle(fontSize: 12,color: Colors.red),))

              ],)),
              //SizedBox(height: 20,),
              Expanded(flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 200,
                  height: 45,
                  child: TextButton(onPressed: (){login(emailController.text.toString(), passwordController.text.toString());}, child: Text('Login',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),

                  )),
                ),
              ),
              //SizedBox(height: 10,),
              Expanded(flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(),
                      Text('Don\'t have account?',style: TextStyle(
                    fontSize: 12
                  ),),
                 
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>registration_page()));}, child: Text('Create a new account',style: TextStyle(
                    fontSize: 12
                  ),))
                ],),
              ),
              // Expanded(flex:2,child: SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
