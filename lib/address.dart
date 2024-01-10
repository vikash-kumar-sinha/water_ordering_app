
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/dashboard.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'orderList.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';
import 'package:flutter/services.dart';
import 'payment.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:crypto/crypto.dart';


class addAddress extends StatefulWidget {
   const addAddress({super.key,required this.smallBottleNumber,required this.largeBottleNumber,required this.currentUserEmail});
   static const String id="addAddress";
   final int smallBottleNumber;
   final int largeBottleNumber;
   final String? currentUserEmail;

  @override
  State<addAddress> createState() => _addAddressState();
}

class _addAddressState extends State<addAddress> {
  //final upiPaymentHandler = UpiPaymentHandler();
  //final _razorpay = Razorpay();
  TextEditingController roomNoController=TextEditingController();

   TextEditingController streetnameController=TextEditingController();

   TextEditingController areaController=TextEditingController();

   TextEditingController cityController=TextEditingController();
   TextEditingController pincodeController=TextEditingController();
   bool _isLoading=true;
  String environment="SANDBOX";
  String appId="";
  String merchantId="PGTESTPAYUAT";
  bool enableLogging=true;
  String checkSum="";
  String saltKey="099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex="1";
  String callbackUrl="www.google.com";
  String body="";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";
  late final orderIdMain;


  getCheckSum(){
    final requestedData={
      "merchantId": merchantId,
      "merchantTransactionId": orderIdMain.toString(),
      "merchantUserId": "90223250",
      "amount": (20 * widget.smallBottleNumber +30 * widget.largeBottleNumber) * 100,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE"}
    };
    String base64body=base64.encode(utf8.encode(json.encode(requestedData)));
    checkSum= '${sha256.convert(utf8.encode(base64body+apiEndPoint+saltKey)).toString()}###$saltIndex';
    return base64body;

  }

  @override
  void initState() {
    // TODO: implement initState
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    orderIdMain=generateOrderId();
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        _isLoading=false;
      });
    });
    phonePeInit();
    body=getCheckSum().toString();
  }
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeeds
  //
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
    //storeAddress();
  //   pushOrderInHistory();
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

 // late final  orderIdmain;


//   Future<void> _initiateTransaction() async {
//     try {
//       bool success = await upiPaymentHandler.initiateTransaction(
//         payeeVpa: 'vikashsinha330@okaxis',
//         payeeName: 'Vikash Kumar Sinha',
//         transactionRefId: '${orderIdmain}',
//         transactionNote: 'Test transaction',
//         amount: 10.0,
//       );
//
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Transaction initiated successfully!')),
//         );
//         await storeAddress();
//         await pushOrderInHistory();
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>dashboard(currentUserEmail: widget.currentUserEmail)));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Transaction initiation failed.')),
//
//         );
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>addAddress(smallBottleNumber: widget.smallBottleNumber, largeBottleNumber: widget.largeBottleNumber, currentUserEmail: widget.currentUserEmail)));
//       }
//     } on PlatformException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.message}')),
//       );
//     }
//   }

  String generateOrderId(){
    final now=DateTime.now();
    final id="${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.microsecondsSinceEpoch}";
    return id;
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

        // var options = {
        //   'key': 'rzp_test_f3F0m3jMymJZIi',
        //   'amount': (20 * widget.smallBottleNumber +
        //       30 * widget.largeBottleNumber) * 100,
        //   //in the smallest currency sub-unit.
        //   'name': 'Vikash Kumar Sinha',
        //   'order_id': 'order_EMBFqjDHEEn80l',
        //   // Generate order_id using Orders API
        //   'description': 'test',
        //   'timeout': 300,
        //   // in seconds
        //   'prefill': {
        //     'contact': '7041477840',
        //     'email': 'vikash.kumar@example.com'
        //   }
        // };
        // _razorpay.open(options);
       // _initiateTransaction();
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>startUpi(smallBottleNumber:widget.smallBottleNumber, largeBottleNumber: widget.largeBottleNumber, currentUserEmail: widget.currentUserEmail)));


        startPgTransaction();


      }
  }


   @override
  Widget build(BuildContext context) {
    return _isLoading?const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
      ),
    ):Scaffold(
      appBar: AppBar(title: const Text('Add Address'),centerTitle: true,backgroundColor: Colors.grey[200],shape: const Border(bottom: BorderSide(width: 3,color: Colors.grey)),),
      body: SafeArea(
        child: Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: roomNoController,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Room no',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.room,color: Colors.blue,),
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
              )),
              const Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: streetnameController,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Street name',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.map,color: Colors.blue,),
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
              )),
              const Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: areaController,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Area',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.near_me,color: Colors.blue,),
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
              )),
              const Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: cityController,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'City',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.location_city,color: Colors.blue,),
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
              )),
              const Gap(10),
              Expanded(flex: 4,child: TextField(
                controller: pincodeController,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),

                decoration: InputDecoration(
                    hintText: 'Pincode',
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    prefixIcon: const Icon(Icons.pin_drop_outlined,color: Colors.blue,),
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
              )),
              const Gap(10),
              Expanded(flex: 5,child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: TextButton(onPressed: () {
                  // setState(() {
                  //   orderIdmain=generateOrderId();
                  // });
                  checkCityPincode();

                  //OrderHistoryDataType order=OrderHistoryDataType(large: 10, small: 5, date: DateTime(2022), time:DateTime(8), price: 400);
                  //OrderHistoryList.add(order);},
                },style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all(Colors.blue)),child: const Text('Proceed for Payment',style: TextStyle(color: Colors.black87,
                    fontWeight: FontWeight.bold,fontSize: 15),),),
              ))
            ],
          ),
        ),),
      ),

    );
  }
  void phonePeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });

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
  pushOrderInHistory()async{

    final userRef=user.collection("Users").doc(widget.currentUserEmail).collection("Order History");
    await userRef.doc(orderIdMain).set({
      'small bottle':widget.smallBottleNumber.toString(),
      'Large bottle':widget.largeBottleNumber.toString(),
      'Price':(20*widget.smallBottleNumber+30*widget.largeBottleNumber).toString(),
      'Date':DateFormat.yMd().format(DateTime.now()).toString(),
      'Time':DateFormat().add_jm().format(DateTime.now()).toString(),
      'Timestamp':orderIdMain.toString()
    }).then((value) {
      UiHelper.customAlertBox(context, "Order Placed successfully");
    });
  }

  void startPgTransaction() async{
    PhonePePaymentSdk.startTransaction(body, callbackUrl, checkSum, "").then((response) => {
      setState(() {
        if (response != null)
        {
          String status = response['status'].toString();
          String error = response['error'].toString();
          if (status == 'SUCCESS')
          {
            result="Flow Completed - Status: Success!";
            UiHelper.customAlertBox(context, "purchase successful and orderid is$orderIdMain");
            storeAddress();
            pushOrderInHistory();

          }
          else {
            result= "Flow Completed - Status: $status and Error: $error";
            UiHelper.customAlertBox(context, "error: $error");
            Navigator.pop(context);
          }
        }
        else {
          result="Flow Incomplete";
          UiHelper.customAlertBox(context, "Transaction failed");
        }
      })
    }).catchError((error) {
      // handleError(error)
      return <dynamic>{};
    });
  }

  void handleError(error) {
    setState(() {
      result={"Error":error};
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // _razorpay.clear();

    super.dispose();
  }
}
