import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:water_ordering_app/dashboard.dart';
import 'package:water_ordering_app/orderList.dart';
import 'package:water_ordering_app/registration.dart';
import 'forgotPassword.dart';
//import 'newDashboard.dart';
import 'dashboard.dart';


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
  bool _isLoading=true;
  login(String email,String password)async{
    if(email=="" && password=="") {
      UiHelper.customAlertBox(context, "Please enter required crediantials");
    } else
      {
        UserCredential? userCrediantial;
        try{
          userCrediantial=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
            emailController.clear();
            passwordController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard(currentUserEmail: email)));
            return null;
          });
        } on FirebaseAuthException catch(ex){
          return UiHelper.customAlertBox(context, ex.code.toString());
        }
      }
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
      body: SafeArea(
        child: Expanded(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(flex:4,child: SizedBox()),
              Expanded(flex: 7,child: Image.asset('images/logo.png',height: 200.0,width: 200.0,)),

              const Expanded(flex: 3,
                child: Text('Welcome back',textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),),
              ),
              Gap(20),
              Expanded(flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: const TextStyle(
                            color: Colors.grey,
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
              //SizedBox(height: 10,),
              Gap(20),
              Expanded(flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(

                    controller: passwordController,
                    obscureText: _passObcure,
                    style: const TextStyle(
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
                        hintStyle: const TextStyle(
                            color: Colors.grey,
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
              Expanded(flex:2,child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10,),
                TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const ForgotPassword()));}, child: const Text('Forgot Password?',style: TextStyle(fontSize: 12,color: Colors.red),))

              ],)),
              //SizedBox(height: 20,),
              Expanded(flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 200,
                  height: 45,
                  child: TextButton(onPressed: (){login(emailController.text.toString(), passwordController.text.toString());},
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),

                  ), child: const Text('Login',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
              //SizedBox(height: 10,),
              Expanded(flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      const Text('Don\'t have account?',style: TextStyle(
                    fontSize: 12
                  ),),
                 
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const registration_page()));}, child: const Text('Create a new account',style: TextStyle(
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
