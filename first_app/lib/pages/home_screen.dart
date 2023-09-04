// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Row(
          children: [
            Expanded(flex:2, child:Container()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30,0, 30,30),
                      child: FittedBox(
                        fit: BoxFit.fitHeight ,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow[700],
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo2.png"),
                            radius: 19,
                          ),
                        ),
                      ),
                    ),

                    OutlinedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/lookUpDisease');
                      },
                      style: OutlinedButton.styleFrom(
                        //side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.yellow[700],
                        foregroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                        ),

                      ),
                      child: const Text(
                          "Enter Disease",
                          style: TextStyle(
                            fontSize: 15,
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/lookUpSymptoms');
                      },
                      style: OutlinedButton.styleFrom(
                        //side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.yellow[700],
                        foregroundColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                        ),

                      ),
                      child: const Text(
                          "Enter Symptoms",
                          style: TextStyle(
                            fontSize: 15,
                          )
                      ),
                    ),
                  ],

                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.copyright_outlined, color: Colors.white,),
                        SizedBox(width: 3,),
                        Text(
                          "Xing Fu Tang",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ]
                ),
            )
          ]
      ),
    );
  }
}


