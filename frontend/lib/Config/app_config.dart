
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//Esta puesto de esta manera para que sea sencillo cambiar en donde se lanza, para que si se tiene dominio se ponga allí
class AppConfig {

  

// true = emulador, false = móvil físico por USB
static const bool isEmulador = false;


static String get baseUrl {
  if (kIsWeb) {
    final host = Uri.base.host;
    if (host == '10.0.2.2') {
      return "http://10.0.2.2:8000";
    }
    return "http://localhost:8000";
  } else if (defaultTargetPlatform == TargetPlatform.android && isEmulador) {
    return "http://10.0.2.2:8000";
  } else {
    return "http://192.168.18.242:8000";
  }
}


 

  static Color get colorScaffold{

  return Colors.orange[50]!;
  
  }

  static Color get colorAppBar {

   return  Colors.orange[300]!; //const Color.fromARGB(255, 255, 142, 77)!; // Colors.orange[300]!; //const Color.fromARGB(255, 240, 122, 75);// Colors.orange[300]!; //rojo capaz ¿? 
  
  }

  static Color get colorNavBar {
  return Colors.redAccent; 
}

 

}