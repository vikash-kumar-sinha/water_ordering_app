import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'orderList.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class addAddress extends StatefulWidget {
   addAddress({super.key,required this.smallBottleNumber,required this.largeBottleNumber,required this.currentUserEmail});
   static const String id="addAddress";
   final int smallBottleNumber;
   final int largeBottleNumber;
   final String? currentUserEmail;

  @override
  State<addAddress> createState() => _addAddressState();
}

class _addAddressState extends State<addAddress> {
  var _razorpay = Razorpay();
  TextEditingController roomNoController=TextEditingController();

   TextEditingController streetnameController=TextEditingController();

   TextEditingController areaController=TextEditingController();

   TextEditingController cityController=TextEditingController();
   TextEditingController pincodeController=TextEditingController();

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
    storeAddress();
    pushOrderInHistory();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  final user=FirebaseFirestore.instance;
  storeAddress() async{
    final userRef=user.collection("Users").doc(widget.currentUserEmail).collection("address").doc(widget.currentUserEmail);
    await userRef.set({
      'Room no.':roomNoController.text.toString(),
      'Street Name':streetnameController.text.toString(),
      'Area':areaController.text.toString(),
      'City':cityController.text.toString(),
      'Pincode':pincodeController.text.toString()
    });
    setState(() {
      roomNoController.clear();
      streetnameController.clear();
      areaController.clear();
      cityController.clear();
      pincodeController.clear();
    });

  }

  String generateOrderId(){
    final now=DateTime.now();

    return now.microsecondsSinceEpoch.toString();
  }

  checkCityPincode(){
    if(cityController.text.toString().toUpperCase() =="" && pincodeController.text.toString().toUpperCase()=="")
      {

        UiHelper.customAlertBox(context,"Please enter city and pincode");
      }
    else if(cityController.text.toString().toUpperCase() !="RANCHI")
      {
        UiHelper.customAlertBox(context, "This water ordering is currently working in ranchi only");

      }
    else if(pincodeController.text.toString().toUpperCase()!="834001")
      {
        UiHelper.customAlertBox(context, "Please provide  correct pincode of ranchi");
      }
    else
      {

        var options = {
          'key': 'rzp_test_f3F0m3jMymJZIi',
          'amount': (20 * widget.smallBottleNumber +
              30 * widget.largeBottleNumber) * 100,
          //in the smallest currency sub-unit.
          'name': 'Vikash Kumar Sinha',
          'order_id': 'order_EMBFqjDHEEn80l',
          // Generate order_id using Orders API
          'description': 'test',
          'timeout': 300,
          // in seconds
          'prefill': {
            'contact': '7041477840',
            'email': 'vikash.kumar@example.com'
          }
        };
        _razorpay.open(options);
      }
  }

  pushOrderInHistory()async{
    final orderId=generateOrderId();
    final userRef=user.collection("Users").doc(widget.currentUserEmail).collection("Order History");
    await userRef.doc(orderId).set({
      'small bottle':widget.smallBottleNumber.toString(),
      'Large bottle':widget.largeBottleNumber.toString(),
      'Price':(20*widget.smallBottleNumber+30*widget.largeBottleNumber).toString(),
      'Date':DateFormat.yMd().format(DateTime.now()).toString(),
      'Time':DateFormat().add_jm().format(DateTime.now()).toString(),
    }).then((value) {
      UiHelper.customAlertBox(context, "Order Placed successfully");
    });
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Address'),centerTitle: true,backgroundColor: Colors.grey[200],shape: Border(bottom: BorderSide(width: 3,color: Colors.grey)),),
      body: SafeArea(
        child: Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: roomNoController,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Room no',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.room,color: Colors.blue,),
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
              )),
              Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: streetnameController,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Street name',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.map,color: Colors.blue,),
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
              )),
              Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: areaController,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Area',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.near_me,color: Colors.blue,),
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
              )),
              Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: cityController,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'City',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.location_city,color: Colors.blue,),
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
              )),
              Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: pincodeController,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Pincode',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: Icon(Icons.pin_drop_outlined,color: Colors.blue,),
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
              )),
              Gap(10),
              Expanded(flex: 5,child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: TextButton(onPressed: () {

                  checkCityPincode();

                  //OrderHistoryDataType order=OrderHistoryDataType(large: 10, small: 5, date: DateTime(2022), time:DateTime(8), price: 400);
                  //OrderHistoryList.add(order);},
                },child: Text('Proceed for Payment',style: TextStyle(color: Colors.black87,
                    fontWeight: FontWeight.bold,fontSize: 15),),style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all(Colors.blue)),),
              ))
            ],
          ),
        ),),
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
