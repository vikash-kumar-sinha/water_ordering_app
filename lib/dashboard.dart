



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/history.dart';
import 'package:water_ordering_app/login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'package:gap/gap.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class dashboard extends StatefulWidget {
  static const String id='dashboard';
   const dashboard({super.key,required this.currentUserEmail});
   final String? currentUserEmail;

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String? userName;
  bool _isLoading=true;
  late final Image smallImage;
  late final Image largeImage;

  getAllImages()async{
    setState(() {
      smallImage=Image.asset('images/small_bottle.jpg');
      largeImage=Image.asset('images/large_bottle.jpg');
    });
  }

  getUser()async{
    final FirebaseAuth auth=  FirebaseAuth.instance;
    final User? user=auth.currentUser;
    final String? currentUserId=user?.email.toString();
    log("id:$currentUserId");
    await FirebaseFirestore.instance.collection("Users").doc(currentUserId).get().then((snapshot){
      if(snapshot.exists)
        {
          setState(() {
            String uName=snapshot.data()?['name'];
            String trimname=uName.trim();
            List<String> words=trimname.split(" ");
            userName="${words[0]} ${words[1]}";
          });


        }
    });
  }
logOut()async{
  await FirebaseAuth.instance.signOut().then((value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const login_page()));
  });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        _isLoading=false;
      });
    });
    getUser();
    getAllImages();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: _isLoading?const Scaffold(
        body: Center(
          child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
        ),
      ):Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
         shape: const Border(bottom: BorderSide(width: 3,color: Colors.grey,)),
          backgroundColor: Colors.blue,
          actions: [IconButton(onPressed: (){logOut();}, icon: const Icon(Icons.logout,color: Colors.black87,)),TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderHistory()));},child: const Icon(Icons.history,color: Colors.black87,))],
          leading: Image.asset('images/logo.png',),
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('Hello,$userName',style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),),
          ),

        ),
        body:NewOrder(currentUserEmail: widget.currentUserEmail,smallImage: smallImage,largeImage: largeImage,)
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
   const RoundedIconButton({super.key,  required this.icon,required this.onPressed});

  final IconData icon;
   final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
    elevation: 6.0,
    constraints: const BoxConstraints.tightFor(width: 40.0,height: 40.0),
    shape: const CircleBorder(),
    fillColor: Colors.lightBlue,
      child: Icon(icon),);
  }
}

class NewOrder extends StatefulWidget {
  const NewOrder({super.key,required this.currentUserEmail,required this.largeImage,required this.smallImage});
  final String? currentUserEmail;
  final Image smallImage;
  final Image largeImage;

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  
  int smallBottleNumber=1;

  int largeBottleNumber=1;


  
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Expanded(
        child: Column(
          children: [
            const Gap(10),
            Expanded(flex: 1,child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.blue[200]),
              margin: const EdgeInsets.symmetric(horizontal: 100,vertical: 3),
              height: 15,
              width: 150,
              padding: const EdgeInsets.symmetric(vertical: 7),

              child: const Text('New order',

                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
            ),),
            const SizedBox(height: 20,),
            Expanded(
              flex:7,child: Container(decoration: BoxDecoration(border: Border.all(
                color: Colors.blue,
                width: 3.0
            ),borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Expanded(flex:6,child: Row(children: [Expanded(child: widget.smallImage ),
                    Expanded(child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        RoundedIconButton(icon: Icons.remove, onPressed: (){
                          setState(() {
                            smallBottleNumber--;
                          });
                        }),
                        const SizedBox(width: 5,),
                        Text(smallBottleNumber.toString(),style: const TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(width: 5,),
                        RoundedIconButton(icon: Icons.add, onPressed: (){
                          setState(() {
                            smallBottleNumber++;
                          });
                        })
                      ],))],)),
                  const SizedBox(child: Divider(height: 3,thickness: 3.0,color: Colors.blue,),),
                  Expanded(flex:6,child: Row(children: [Expanded(child: widget.largeImage),
                    Expanded(child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        RoundedIconButton(icon: Icons.remove, onPressed: (){
                          setState(() {
                            largeBottleNumber--;
                          });
                        }),
                        const SizedBox(width: 5,),
                        Text(largeBottleNumber.toString(),style: const TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(width: 5,),
                        RoundedIconButton(icon: Icons.add, onPressed: (){
                          setState(() {
                            largeBottleNumber++;
                          });
                        })
                      ],))],)),
                  const SizedBox(child: Divider(height: 3,thickness: 3.0,color: Colors.blue,),),
                  Expanded(flex: 2,child: Row(
                    children: [
                      const Expanded(child: Center(child: Text('Total',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.bold
                      ),))),
                      const SizedBox(child: VerticalDivider(width:3,thickness: 3.0,color: Colors.blue,),),
                      Expanded(child: Center(child: Text('\u{20B9}${smallBottleNumber*20+largeBottleNumber*30}',style: const TextStyle(
                          fontSize: 15,fontWeight: FontWeight.bold
                      ),))),

                    ],
                  )),
                  

                ],
              ),),


            ),
            //Expanded(flex: 1,child: SizedBox(height: 10,)),
            Expanded(flex: 2,child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: TextButton(onPressed: (){                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>addAddress(
                    smallBottleNumber: smallBottleNumber, largeBottleNumber: largeBottleNumber,currentUserEmail: widget.currentUserEmail,)));
                },style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all(Colors.blue)), child: const Text('Proceed for address',style: TextStyle(color: Colors.black87,
                  fontWeight: FontWeight.bold,fontSize: 15),),),
            ))

          ],
        ),
      ),
    );

  }
 
}


