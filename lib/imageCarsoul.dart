import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://img.freepik.com/free-vector/world-water-day-hand-drawn_23-2148847940.jpg?ga=GA1.1.413827823.1699978887&semt=ais',
  'https://img.freepik.com/free-vector/water-concept-illustration_114360-8494.jpg?ga=GA1.1.413827823.1699978887&semt=ais',
  'https://img.freepik.com/free-vector/flat-world-water-day-infographic-template_23-2149261314.jpg?ga=GA1.1.413827823.1699978887&semt=ais',
  'https://img.freepik.com/free-vector/watercolor-world-water-day-infographic-template_52683-81623.jpg?ga=GA1.1.413827823.1699978887&semt=ais',
  'https://img.freepik.com/free-vector/tiny-woman-pouring-clean-water-from-faucet-with-mountain-landscape_74855-11024.jpg?ga=GA1.1.413827823.1699978887&semt=ais',
  'https://img.freepik.com/free-photo/eco-message-bottle-concept_23-2149696311.jpg?size=626&ext=jpg&ga=GA1.1.413827823.1699978887&semt=ais',


];



final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                // child: Text(
                //   'No. ${imgList.indexOf(item)} image',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();
class NoonLooping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 2,
              autoPlay: true,
            ),
            items: imageSliders,
          ));

  }
}