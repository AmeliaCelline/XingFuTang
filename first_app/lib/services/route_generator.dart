// ignore_for_file: prefer_const_constructors

import 'package:first_app/pages/home_screen.dart';
import 'package:first_app/pages/lookup_disease.dart';
import 'package:first_app/pages/testing.dart';
import 'package:first_app/pages/result.dart';
import 'package:first_app/services/diseases.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/lookup_symptoms.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/lookUpDisease':
        return MaterialPageRoute(builder: (_) => LookUpDisease());
      case '/lookUpSymptoms':
        return MaterialPageRoute(builder: (_) => Model());
      case '/testing':
        return MaterialPageRoute(builder: (_) => CarouselDemo());
      case '/result':
        return MaterialPageRoute(builder: (_) => Result(disease:settings.arguments as Diseases));
      default:
        return MaterialPageRoute(builder: (_) =>
            Scaffold(appBar: AppBar(title: Text("Error")))
        );
    }
  }

}