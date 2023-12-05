import 'package:flutter/material.dart';

class addAddress extends StatefulWidget {
   addAddress({super.key});
   static const String id="addAddress";

  @override
  State<addAddress> createState() => _addAddressState();
}

class _addAddressState extends State<addAddress> {
  TextEditingController roomNoController=TextEditingController();

   TextEditingController streetnameController=TextEditingController();

   TextEditingController areaController=TextEditingController();

   TextEditingController cityController=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Address'),centerTitle: true,),
        body: Expanded(child: Column(
          children: [
            Expanded(child: TextField(
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
                      fontSize: 18
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
            Expanded(child: TextField(
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
                      fontSize: 18
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
            Expanded(child: TextField(
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
                      fontSize: 18
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
            Expanded(child: TextField(
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
                      fontSize: 18
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
            ))
          ],
        ),),

      ),
    );
  }
}
