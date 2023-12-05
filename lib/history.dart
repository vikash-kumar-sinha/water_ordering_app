import 'package:flutter/material.dart';
import 'orderList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});
  static const String id="history";

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(foregroundColor: Colors.white,
          title: Center(child: Text('Your Orders',)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Order',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                Text('Date & Time',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                Text('Total Cost',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
              ],),
            ),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: OrderHistoryList.length,
            itemBuilder: (context, index){
              OrderHistoryDataType order=OrderHistoryList[index];
              return Card(
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    Row(

                      children: [
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            Text('Small bottles : ${order.small}'),
                            Text('large bottles  : ${order.large}')
                          ],
                        ),
                        SizedBox(width: 5,),
                        Row(children: [
                          Text('${order.date}'),
                          SizedBox(width: 5,),
                          Text('${order.time}')
                        ],),
                        SizedBox(width: 5,),
                        Text('\u{20B9} ${order.price}')
                      ],)
                  ],
                ),
              );
            }),
      ),
          ],
        )

      ),
    );
  }
}

class orders extends StatefulWidget {
  const orders({super.key});

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: OrderHistoryList.length,
        itemBuilder: (context, index){
          OrderHistoryDataType order=OrderHistoryList[index];
          return Card(
            child: Column(
              children: [
                SizedBox(height: 5,),
                Row(

                  children: [
                    SizedBox(width: 5,),
                    Column(
                      children: [
                        Text('Small bottles : ${order.small}'),
                        Text('large bottles  : ${order.large}')
                      ],
                    ),
                    SizedBox(width: 5,),
                    Row(children: [
                      Text('${order.date}'),
                      SizedBox(width: 5,),
                      Text('${order.time}')
                    ],),
                    SizedBox(width: 5,),
                    Text('\u{20B9} ${order.price}')
                  ],)
              ],
            ),
          );
        });
  }
}

class AddNewOrder extends StatelessWidget {
  const AddNewOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 5,),
          Row(

            children: [
              SizedBox(width: 5,),
            Column(
              children: [
                Text('Small bottles : 5'),
                Text('large bottles  : 1')
              ],
            ),
            SizedBox(width: 80,),
            Row(children: [
              Text('21/10/2023'),
              SizedBox(width: 10,),
              Text('23:10')
            ],),
            SizedBox(width: 130,),
            Text('\u{20B9} 130')
          ],)
        ],
      ),
    );
  }
}
