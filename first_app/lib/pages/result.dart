// ignore_for_file: prefer_const_constructors
import 'package:first_app/services/diseases.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auto_size_text/auto_size_text.dart';


Diseases ? globalDisease;


class Result extends StatelessWidget {
  final Diseases disease;
  const Result({Key ? key, required this.disease}) : super(key: key);
  //const Result({super.key});

  @override
  Widget build(BuildContext context) {
    globalDisease = disease;
    Color ? yellowApp = Color(0xfffbc02d);
    Color ? blackApp = Color(0xff212121);
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackApp,
      appBar: AppBar(
        title: Text("Result"),
        backgroundColor: blackApp,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      width: mediaWidth,
                      color: yellowApp,
                    ),
                  ),
                  ImageCarousel(),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 25),
                      child: Text(disease.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Quantico',
                          letterSpacing: 1,
                          color: yellowApp,
                        ),
                        textAlign: TextAlign.center,

                      ),
                    ),
                    Text('DESCRIPTION',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Quantico',
                        letterSpacing: 1.5,
                        color: yellowApp,
                      ),
                    ),
                    Container(
                      width: mediaWidth,
                      height: 1.3,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    Text(disease.description, style: TextStyle(fontSize: 17, color: Colors.white), textAlign: TextAlign.center,),
                    SizedBox(height: 20,),
                    Text('PRECAUTIONS',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Quantico',
                        letterSpacing: 1.5,
                        color: yellowApp,
                      ),
                    ),
                    Container(
                      width: mediaWidth,
                      height: 1.3,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      itemBuilder: (context, index){
                        return Text(disease.precautions[index], style: TextStyle(fontSize: 17, fontFamily: 'Quantico', color: Colors.white), textAlign: TextAlign.center,);
                      },
                      itemCount: disease.precautions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(height: 20,),
                    Text('POSSIBLE SYMPTOMS',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Quantico',
                        letterSpacing: 1.5,
                        color: yellowApp,
                      ),
                    ),
                    Container(
                      width: mediaWidth,
                      height: 1.3,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10,),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (1 / .5)

                    ),

                      itemBuilder: (context, index){
                        return Container(
                          constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: yellowApp,

                          ),
                          child: Center(child:
                            AutoSizeText(disease.symptoms[index], textAlign: TextAlign.center,)
                          ),
                        );
                      },
                      itemCount: disease.symptoms.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key ? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(

      items: ['assets/diseaseImage/${globalDisease?.index}/0.jpeg', 'assets/diseaseImage/${globalDisease?.index}/1.jpeg', 'assets/diseaseImage/${globalDisease?.index}/2.jpeg'].map((i){
      // items: ['assets/logo.jpg'].map((i){
        return SizedBox(
          width: mediaWidth,
          height: mediaWidth * 9 / 16,
          child: Image.asset(i),
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
      ),
    );
  }
}
