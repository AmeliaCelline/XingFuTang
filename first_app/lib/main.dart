// ignore_for_file: prefer_const_constructors
import 'package:first_app/services/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
  )

  );
}
