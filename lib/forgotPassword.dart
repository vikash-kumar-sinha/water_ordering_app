import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:water_ordering_app/orderList.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
  bool _isLoading=true;
  forgotPassword(String email)async{
    if(email=="") {
      return UiHelper.customAlertBox(context, "Please enter email to Reset Password");
    } else
      {
         FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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
    return SafeArea(
      child: _isLoading?const Scaffold(
        body: Center(
          child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
        ),
      ):Scaffold(
        appBar: AppBar(
          shape: const Border(bottom: BorderSide(width: 3,color: Colors.grey,)),
          title: const Text('Forgot Password',style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
              TextField(
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
                        fontSize: 18
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
              const SizedBox(height: 20,),
              TextButton(onPressed: (){forgotPassword(emailController.text.toString());},
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),

                  ), child: const Text('Reset Password',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),)),
            ],),
          ),
        ),
      ),
    );
  }
}
