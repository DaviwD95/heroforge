import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//Esta puesto de esta manera para que sea sencillo cambiar en donde se lanza, para que si se tiene dominio se ponga allí
class AppConfig {

  static String get baseUrl {

    if (kIsWeb) {
      return "http://localhost:8000";
    } else {
      return "http://192.168.18.242:8000";
    }
  }

 

  static Color get colorScaffold{

  return Colors.orange[50]!;
  
  }

   static Color get colorAppBar {

  return  Colors.orange[100]!; //rojo capaz ¿? 
  
  }

  static Color get colorNavBar {
  return Colors.redAccent; 
}

 

}