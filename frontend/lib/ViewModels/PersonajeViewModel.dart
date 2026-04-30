
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/Screens/Personajes/personaje_add_basico.dart';
import 'package:heroforge/models/Auth/auth_provider.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:heroforge/models/directorio_personajes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PersonajeViewModel extends ChangeNotifier {

  final String baseUrl = AppConfig.baseUrl;

  DirectorioPersonajes directorio;

  int get numPersonajes=> directorio.personajes.length; 

  //Si es andriid usa localHost (porque no tengo domain, si no pues el movil que es mi direccion IP )

  PersonajeViewModel(this.directorio);





  void init(BuildContext context) async 
  {
    await cargarPersonajes(context);
  }

  Future<bool?> cargarPersonajes(BuildContext context) async 
  {

     final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.get(Uri.parse("$baseUrl/Personajes/get"),
     headers: {"Content-Type": "application/json",
              "Authorization": "Bearer $token",
              },    
      );

    if(response.statusCode == 200)
     {

      final List data = jsonDecode(response.body);

      directorio.setPersonajes(data.map((e) => Personaje.fromJson(e)).toList(),);
   

     }
  }

  Future<bool?> addPersonaje(BuildContext context) async 
  {
    Personaje personajeNuevo = Personaje();

    bool? condicion =await  Navigator.of(context).push<bool?>(MaterialPageRoute(builder: (context) => PersonajeAddBasico(personaje: personajeNuevo),),);
    //  print(jsonEncode(usuarioNuevo.toJson()));

    


    return null;




  }

}