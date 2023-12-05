import 'package:flutter/material.dart';
class OrderHistoryDataType {
  late int large;
  late int small;
  late DateTime date;
  late DateTime time;
  late int price;

  OrderHistoryDataType({required this.large,required this.small,required this.date,required this.time,required this.price,});
}

List<OrderHistoryDataType> OrderHistoryList=[
  OrderHistoryDataType(large: 5, small: 2, date: DateTime(2023), time: DateTime(8), price: 190),
  OrderHistoryDataType(large: 5, small: 2, date: DateTime(2023), time: DateTime(8), price: 190),
];

class UiHelper{
  static customAlertBox(BuildContext context,String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title:Text(text),actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Ok'))
      ],);
    });
  }
}