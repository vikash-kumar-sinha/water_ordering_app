



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/history.dart';
import 'package:water_ordering_app/login.dart';
import 'orderList.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'package:gap/gap.dart';

class dashboard extends StatefulWidget {
  static const String id='dashboard';
   dashboard({super.key,required this.currentUserEmail});
   final String? currentUserEmail;

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String? userName;


  getUser()async{
    final FirebaseAuth auth=  FirebaseAuth.instance;
    final User? user=await auth.currentUser;
    final String? currentUserId=user?.email.toString();
    log("id:${currentUserId}");
    await FirebaseFirestore.instance.collection("Users").doc(currentUserId).get().then((snapshot){
      if(snapshot.exists)
        {
          setState(() {
            String uName=snapshot.data()?['name'];
            String trimname=uName.trim();
            List<String> words=trimname.split(" ");
            userName=words[0];
          });


        }
    });
  }
logOut()async{
  await FirebaseAuth.instance.signOut().then((value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => login_page()));
  });
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
         shape: Border(bottom: BorderSide(width: 3,color: Colors.grey,)),
          backgroundColor: Colors.grey[200],
          actions: [IconButton(onPressed: (){logOut();}, icon: Icon(Icons.logout)),TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistory()));},child: Icon(Icons.history,color: Colors.black87,))],
          leading: Image.asset('images/logo.png',),
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('Hello,${userName}',style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
          ),

        ),
        body:NewOrder(currentUserEmail: widget.currentUserEmail)
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
   RoundedIconButton({ required this.icon,required this.onPressed});

  final IconData icon;
   final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon),
    elevation: 6.0,
    constraints: BoxConstraints.tightFor(width: 40.0,height: 40.0),
    shape: CircleBorder(),
    fillColor: Colors.lightBlue,);
  }
}

class NewOrder extends StatefulWidget {
  const NewOrder({super.key,required this.currentUserEmail});
  final String? currentUserEmail;

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
            Gap(10),
            Expanded(flex: 1,child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey[200]),
              margin: EdgeInsets.symmetric(horizontal: 100,vertical: 3),
              height: 15,
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 7),

              child: Text('New order',

                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
            ),),
            SizedBox(height: 20,),
            Expanded(
              flex:7,child: Container(decoration: BoxDecoration(border: Border.all(
                color: Colors.blue,
                width: 3.0
            ),borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Expanded(flex:6,child: Row(children: [Expanded(child: Image.asset('images/small_bottle.jpg')),
                    Expanded(child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        RoundedIconButton(icon: Icons.remove, onPressed: (){
                          setState(() {
                            smallBottleNumber--;
                          });
                        }),
                        SizedBox(width: 5,),
                        Text(smallBottleNumber.toString(),style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 5,),
                        RoundedIconButton(icon: Icons.add, onPressed: (){
                          setState(() {
                            smallBottleNumber++;
                          });
                        })
                      ],))],)),
                  SizedBox(child: Divider(height: 3,thickness: 3.0,color: Colors.blue,),),
                  Expanded(flex:6,child: Row(children: [Expanded(child: Image.asset('images/large_bottle.jpg')),
                    Expanded(child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        RoundedIconButton(icon: Icons.remove, onPressed: (){
                          setState(() {
                            largeBottleNumber--;
                          });
                        }),
                        SizedBox(width: 5,),
                        Text(largeBottleNumber.toString(),style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 5,),
                        RoundedIconButton(icon: Icons.add, onPressed: (){
                          setState(() {
                            largeBottleNumber++;
                          });
                        })
                      ],))],)),
                  SizedBox(child: Divider(height: 3,thickness: 3.0,color: Colors.blue,),),
                  Expanded(flex: 2,child: Row(
                    children: [
                      Expanded(child: Center(child: Text('Total',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.bold
                      ),))),
                      SizedBox(child: VerticalDivider(width:3,thickness: 3.0,color: Colors.blue,),),
                      Expanded(child: Center(child: Text('\u{20B9}${smallBottleNumber*20+largeBottleNumber*30}',style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.bold
                      ),))),

                    ],
                  )),
                  

                ],
              ),),


            ),
            //Expanded(flex: 1,child: SizedBox(height: 10,)),
            Expanded(flex: 2,child: Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: TextButton(onPressed: (){                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>addAddress(
                    smallBottleNumber: smallBottleNumber, largeBottleNumber: largeBottleNumber,currentUserEmail: widget.currentUserEmail,)));
                }, child: Text('Proceed for address',style: TextStyle(color: Colors.black87,
                  fontWeight: FontWeight.bold,fontSize: 15),),style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all(Colors.blue)),),
            ))

          ],
        ),
      ),
    );

  }
 
}


