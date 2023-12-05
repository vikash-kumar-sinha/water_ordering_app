



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/history.dart';
import 'package:water_ordering_app/login.dart';
import 'orderList.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';

class dashboard extends StatefulWidget {
  static const String id='dashboard';
   dashboard({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
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
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),

          ),
          body:NewOrder()
        ),
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
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  var _razorpay = Razorpay();
  int smallBottleNumber=1;

  int largeBottleNumber=1;
  String address="click here to add address-->";

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('payment failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(

        children: [

          Expanded(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blue),
              margin: EdgeInsets.symmetric(horizontal: 100,),
              height: 30,
              width: 150,
              padding: EdgeInsets.symmetric(vertical: 7),

              child: Text('New order',

                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),),
          SizedBox(height: 20,),
          Expanded(
            flex:8,child: Container(decoration: BoxDecoration(border: Border.all(
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
                SizedBox(child: Divider(height: 3,thickness: 3.0,color: Colors.blue,),),
                Expanded(flex:3,child: Row(

                  children: [
                    Expanded(child: Center(child: Text('Address',style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.bold
                    ),))),
                    SizedBox(child: VerticalDivider(width:3,thickness: 3.0,color: Colors.blue,),),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Expanded(flex: 1,child: SizedBox(width: 5,)),
                        Expanded(flex:3,child: Text('${address}',style: TextStyle(fontWeight: FontWeight.bold),)),
                        Expanded(flex:3,child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>addAddress()));
                        }, icon: Icon(Icons.add_location_alt,color: Colors.blue,),autofocus: true,))
                      ],
                    )),

                  ],
                )),

              ],
            ),),


          ),
          Expanded(flex: 1,child: SizedBox(height: 10,)),
          Expanded(flex: 2,child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: TextButton(onPressed: (){
              var options = {
                'key': 'rzp_test_f3F0m3jMymJZIi',
                'amount': (20*smallBottleNumber+30*largeBottleNumber)*100, //in the smallest currency sub-unit.
                'name': 'Vikash Kumar Sinha',
                'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'description': 'test',
                'timeout': 300, // in seconds
                'prefill': {
                  'contact': '9123456789',
                  'email': 'vikash.kumar@example.com'
                }
              };
              _razorpay.open(options);
              OrderHistoryDataType order=OrderHistoryDataType(large: 10, small: 5, date: DateTime(2022), time:DateTime(8), price: 400);
              OrderHistoryList.add(order);}, child: Text('Proceed for Payment',style: TextStyle(color: Colors.black87,
                fontWeight: FontWeight.bold,fontSize: 16),),style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all(Colors.blue)),),
          ))

        ],
      ),
    );

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}


