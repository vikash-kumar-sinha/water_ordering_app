
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'orderList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});
  static const String id="history";

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final user=FirebaseFirestore.instance;
  bool _isLoading=true;

  //List<OrderHistoryDataType> ordersList=[];
  List<dynamic> ordersList=[];
  Future<String?> getUserEmail()async{
    final FirebaseAuth user=FirebaseAuth.instance;
    final User?  userId=user.currentUser;
    final String? userName=userId?.email.toString();
    return userName;
  }



  Future<void> getDocuments()async{
     final userId=await getUserEmail();
    // final userRef= await user.collection('User').doc(userId).collection('Order History').get();
    // final data=userRef.docs.map((e) => OrderHistoryDataType.fromJson(e.data() as Map<String,dynamic>)).toList();
    // if(data.isEmpty)
    //   {
    //     UiHelper.customAlertBox(context, "No data found");
    //   }
    // setState(() {
    //   ordersList=data;
    // });
   final userRef= await user.collection("Users").doc(userId).collection("Order History").orderBy("Timestamp",descending: true).get().then(
          (querySnapshot) {
        print("Successfully completed");
        final list=[];
        for (var docSnapshot in querySnapshot.docs) {

          list.add(docSnapshot.data());
          // print('${list[0]["Price"]} => ${list[0]["Date"]}');
          // print('${list[0].id}');
        }
        setState(() {
          ordersList=list;
        });
      },
      onError: (e) => UiHelper.customAlertBox(context, "Error completing: $e"),
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        _isLoading=false;
      });
    });
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
      ),
    ):Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
        title: const Text('Your Orders',style: TextStyle(
            fontFamily: 'heading',
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body: Column(
        children: [
          const Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Gap(10),
              Text('Orders',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'salsa'),),
              Gap(40),
              Text('Date & Time',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 13,fontFamily: 'salsa'),),
              Gap(20),
              Text('Price',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 13,fontFamily: 'salsa'),),
            ],),
          ),
    Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ordersList.length,
          itemBuilder: (context, index){
            final order=ordersList[index];
            return Card(
              child: Column(
                children: [
                  const SizedBox(height: 5,),
                  Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        children: [
                          Text('Small bottles : ${order["small bottle"]}',style: orderTextstyle,),
                          Text('large bottles  : ${order["Large bottle"]}',style: orderTextstyle,)
                        ],
                      ),
                      const SizedBox(width: 5,),
                      Row(children: [
                        Text('${order["Date"]}',style: orderTextstyle,),
                        const SizedBox(width: 5,),
                        Text('${order["Time"]}',style: orderTextstyle,)
                      ],),
                      const SizedBox(width: 5,),
                      Text('\u{20B9} ${order["Price"]}',style: orderTextstyle,)
                    ],)
                ],
              ),
            );
          }),
    ),
        ],
      )

    );
  }
}

// class orders extends StatefulWidget {
//   const orders({super.key});
//
//
//   @override
//   State<orders> createState() => _ordersState();
// }

// class _ordersState extends State<orders> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: OrderHistoryList.length,
//         itemBuilder: (context, index){
//           OrderHistoryDataType order=OrderHistoryList[index];
//           return Card(
//             child: Column(
//               children: [
//                 SizedBox(height: 5,),
//                 Row(
//
//                   children: [
//                     SizedBox(width: 5,),
//                     Column(
//                       children: [
//                         Text('Small bottles : ${order.small}'),
//                         Text('large bottles  : ${order.large}')
//                       ],
//                     ),
//                     SizedBox(width: 5,),
//                     Row(children: [
//                       Text('${order.date}'),
//                       SizedBox(width: 5,),
//                       Text('${order.time}')
//                     ],),
//                     SizedBox(width: 5,),
//                     Text('\u{20B9} ${order.price}')
//                   ],)
//               ],
//             ),
//           );
//         });
//   }
// }

// class AddNewOrder extends StatelessWidget {
//   const AddNewOrder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           SizedBox(height: 5,),
//           Row(
//
//             children: [
//               SizedBox(width: 5,),
//             Column(
//               children: [
//                 Text('Small bottles : 5'),
//                 Text('large bottles  : 1')
//               ],
//             ),
//             SizedBox(width: 80,),
//             Row(children: [
//               Text('21/10/2023'),
//               SizedBox(width: 10,),
//               Text('23:10')
//             ],),
//             SizedBox(width: 130,),
//             Text('\u{20B9} 130')
//           ],)
//         ],
//       ),
//     );
//   }
// }
