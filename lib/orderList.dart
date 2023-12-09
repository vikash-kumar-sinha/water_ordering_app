import 'package:flutter/material.dart';
class OrderHistoryDataType {
  late int large;
  late int small;
  late DateTime date;
  late DateTime time;
  late int price;

  OrderHistoryDataType({required this.large,required this.small,required this.date,required this.time,required this.price,});

  factory OrderHistoryDataType.fromJson(Map<String, dynamic> json)=> OrderHistoryDataType(
      large: json['Large bottle'],
      small: json['small bottle'],
      date: json['Date'],
      time: json['Time'],
      price: json['Price']);
}

// List<OrderHistoryDataType> OrderHistoryList=[
//   OrderHistoryDataType(large: 5, small: 2, date: DateTime(2023), time: DateTime(8), price: 190),
//   OrderHistoryDataType(large: 5, small: 2, date: DateTime(2023), time: DateTime(8), price: 190),
// ];

class UiHelper{
  static customAlertBox(BuildContext context,String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title:Text(text,textScaleFactor: 1,),actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text('Ok'))
      ],);
    });
  }
}

const TextStyle orderTextstyle=TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.bold
);