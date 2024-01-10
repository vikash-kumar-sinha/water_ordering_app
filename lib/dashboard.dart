



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_ordering_app/history.dart';
import 'package:water_ordering_app/login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_ordering_app/orderList.dart';
import 'address.dart';
import 'package:gap/gap.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'imageCarsoul.dart';
const story="""It all started with a simple observation: access to clean, refreshing water shouldn't be a luxury. We saw the struggle of lugging heavy bottles and the frustration of unreliable delivery services. Inspired by a vision of making sustainable hydration accessible to everyone, [App Name] was born.
""";
const additional="""Add a personal touch by mentioning the founders' story or what sparked their passion for water delivery.
Highlight your unique selling points, such as local sourcing, eco-friendly packaging, or delivery flexibility.
Showcase your commitment to sustainability with data on your environmental initiatives.
Include a call to action to encourage users to download the app and join your mission.""";
const mission="""Delivering Purity: We partner with trusted local sources to bring you the highest quality water, rigorously tested to meet the strictest standards. Whether it's spring water, natural mineral water, or filtered options, we ensure every drop is delicious and healthy.
Convenience Reimagined: Forget bulky bottles and inconvenient refills. Order your water with a few taps in our user-friendly app, and we'll deliver it straight to your doorstep, on your schedule.
Sustainability at Heart: We're committed to minimizing our environmental footprint. We use reusable glass bottles and promote recycling initiatives to reduce plastic waste. Every sip with [App Name] is a step towards a greener future.
Giving Back to the Community: We believe in making a difference beyond your doorstep. We partner with local charities and water conservation projects to ensure everyone has access to clean water and a healthy environment.
Join the Hydration Revolution:

With [App Name], you're not just choosing water, you're choosing a sustainable future. Every order supports our mission to deliver pure hydration and a healthier planet, one sip at a time.

Ready to experience the difference? Download our app and quench your thirst, the responsible way!""";
const about="""At [App Name], we're more than just water delivery. We're a passionate team dedicated to providing you with the purest, most convenient hydration experience while nurturing a healthier planet.
""";

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

    await FirebaseFirestore.instance.collection("Users").doc(currentUserId).get().then((snapshot){
      if(snapshot.exists)
        {

          setState(() {

            String uName=snapshot.data()?['name'];

            String trimname=uName.trim();

            List<String> words=trimname.split(" ");

            //userName="${words[0]}";
            userName=words[0][0].toUpperCase()+words[0].substring(1);//+" "+words[1][0].toUpperCase()+words[1].substring(1);

            _isLoading=false;
          });


        }else{
        _isLoading=false;
        return UiHelper.customAlertBox(context, "Data not found");
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
    // Future.delayed(const Duration(seconds: 3),(){
    //   setState(() {
    //     _isLoading=false;
    //   });
    // });
    getUser();


    getAllImages();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading?const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
      ),
    ):Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 20,
       shape: const Border(bottom: BorderSide(width: 3,color: Colors.grey,)),
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: (){logOut();}, icon: const Icon(Icons.logout,color: Colors.white,)),TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderHistory()));},child: const Icon(Icons.history,color: Colors.white,))],
        leading: Image.asset('images/logo.png',),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Hello, $userName',style: const TextStyle(
            fontFamily: 'heading',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
        ),

      ),

      body:ListView(
        children: [
          NoonLooping(),
          Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('About the Company',style: aboutTextStyle,),
                  SizedBox(child: Divider(thickness: 3,color: Colors.black87,),width: 150,),
                  Card(color: Colors.blue[300],elevation:5,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(about,softWrap: true,textAlign: TextAlign.justify,style: cardtextStyle),
                  )),
                  Gap(20),
                  Text('Our Story',style: aboutTextStyle,),
                  SizedBox(child: Divider(thickness: 3,color: Colors.black87,),width: 70,),
                  Card(color: Colors.blue[300],elevation:5,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(story,softWrap: true,textAlign: TextAlign.justify,style: cardtextStyle),
                  )),
                  Gap(20),
                  Text('Our Mission',style: aboutTextStyle,),
                  SizedBox(child: Divider(thickness: 3,color: Colors.black87,),width: 90,),
                  Card(color: Colors.blue[300],elevation:5,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(mission,softWrap: true,textAlign: TextAlign.justify,style: cardtextStyle),
                  )),
                  Gap(20),
                  Text(' Additional points to consider',style: aboutTextStyle,),
                  SizedBox(child: Divider(thickness: 3,color: Colors.black87,),width: 220,),
                  Card(color: Colors.blue[300],elevation:5,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(additional,softWrap: true,textAlign: TextAlign.justify,style: cardtextStyle),
                  )),
                  Gap(20),
                  Text('Founder',style: aboutTextStyle,),
                  SizedBox(child: Divider(thickness: 3,color: Colors.black87,),width: 65,),
                  Column(
                    children: [
                      CircleAvatar(radius: 80,backgroundImage: AssetImage('images/vikas.jpeg')),
                      Text('Mr. Vikash Kumar Sinha',style: aboutTextStyle,)
                    ],
                  )
                ],
              ),
            ),
          ),

          Divider(thickness: 2,),
          Gap(60)


        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>New(currentUserEmail: widget.currentUserEmail,smallImage: smallImage,largeImage: largeImage,),)),
        backgroundColor: Colors.blue,
        icon: Icon(Icons.add),
        label: Text('New Order',style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.bold
        ),),
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


class New extends StatefulWidget {
  const New({super.key,required this.currentUserEmail,required this.largeImage,required this.smallImage});
  final String? currentUserEmail;
  final Image smallImage;
  final Image largeImage;


  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  bool _isLoading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        _isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading?Scaffold(
        body: Center(
          child: SpinKitWaveSpinner(color: Colors.blue,size: 150,waveColor: Colors.blue,),
        ),
      ):Scaffold(
        appBar: AppBar(title: Text('New Order'),centerTitle: true,backgroundColor: Colors.blue,),
        body: NewOrder(currentUserEmail: widget.currentUserEmail,smallImage: widget.smallImage,largeImage: widget.largeImage,),
      ),
    );
  }
}
