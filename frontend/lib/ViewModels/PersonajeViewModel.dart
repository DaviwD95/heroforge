
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/Screens/Personajes/personaje_add_1.dart';
import 'package:heroforge/Screens/Personajes/personaje_add_2.dart';
import 'package:heroforge/Screens/Personajes/personaje_add_3.dart';
import 'package:heroforge/models/Auth/auth_provider.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:heroforge/models/directorio_personajes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PersonajeViewModel extends ChangeNotifier {

  final String baseUrl = AppConfig.baseUrl;

  DirectorioPersonajes directorio;

  DirectorioPersonajes directorioPersonajesPublicados;

  int get numPersonajes=> directorio.personajes.length; 

  //Si es andriid usa localHost (porque no tengo domain, si no pues el movil que es mi direccion IP )

  PersonajeViewModel(this.directorio, this.directorioPersonajesPublicados);





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

    Personaje? personaje1  = await  Navigator.of(context).push<Personaje?>(MaterialPageRoute(builder: (context) => PersonajeAdd1(personaje: personajeNuevo),),);
    //  print(jsonEncode(usuarioNuevo.toJson()));

    if (personaje1 == null) return null;    

    Personaje? personaje2 = await  Navigator.of(context).push<Personaje?>(MaterialPageRoute(builder: (context) => PersonajeAdd2(personaje: personaje1),),);


    if (personaje2 == null) return null;



    Personaje? personaje3 = await Navigator.of(context).push<Personaje?>( MaterialPageRoute(builder: (context) => PersonajeAdd3(personaje: personaje2)),);

    if (personaje3 == null) return null;

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    personaje3.idUsuario = Provider.of<AuthProvider>(context, listen: false).user!.id;


    final response = await http.post(

        Uri.parse("$baseUrl/Personajes/add"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token",},
        body:  jsonEncode(personaje3.toJson())
      );

    if (response.statusCode == 200)
    {
      final data = jsonDecode(response.body);
      personaje3.id = data['id'];
          
      directorio.agregar(personaje3);
      return true;

    }else
    {
      return false;
    }


  }


  Future<bool?> editPersonaje(BuildContext context, Personaje personaje) async 
  {
    

    Personaje? personaje1  = await  Navigator.of(context).push<Personaje?>(MaterialPageRoute(builder: (context) => PersonajeAdd1(personaje: personaje),),);
    //  print(jsonEncode(usuarioNuevo.toJson()));

    if (personaje1 == null) return null;    

    Personaje? personaje2 = await  Navigator.of(context).push<Personaje?>(MaterialPageRoute(builder: (context) => PersonajeAdd2(personaje: personaje1),),);


    if (personaje2 == null) return null;



    Personaje? personaje3 = await Navigator.of(context).push<Personaje?>( MaterialPageRoute(builder: (context) => PersonajeAdd3(personaje: personaje2)),);

    if (personaje3 == null) return null;

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.post(

        Uri.parse("$baseUrl/Personajes/edit"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token",},
        body:  jsonEncode(personaje3.toJson())
      );

    if (response.statusCode == 200) {

      //Busco el id y ya lo asigno 

      final index = directorio.personajes.indexWhere(
        (p) => p.id == personaje3.id,
      );

      if (index != -1) {
        directorio.actualizar(index, personaje3);
      }

      return true;
      
    }else
    {
      return false;
    }

  }


  
  Future<bool?> removePersonaje(BuildContext context, Personaje? personaje) async 
  {    

    
    if (personaje == null) return null;

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.post(

        Uri.parse("$baseUrl/Personajes/remove"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token",},
        body:  jsonEncode(personaje.toJson())
      );

    if (response.statusCode == 200) {


      directorio.eliminar(personaje.id!);

      return true;
      
    }else
    {
      return false;
    }

  }

  Future<void> getPersonajesPublicados(BuildContext context) async {

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.get(

      Uri.parse("$baseUrl/Personajes/Publicados/get"),
      headers: {"Content-Type": "application/json",
              "Authorization": "Bearer $token",},
                  
      );

    if(response.statusCode == 200)
     {

      final List data = jsonDecode(response.body);

      directorioPersonajesPublicados.setPersonajes(data.map((e) => Personaje.fromJson(e)).toList(),);        
   

     }
    
    
  }


  Future<bool?> publicarPersonaje(BuildContext context, Personaje personaje) async {

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.post(Uri.parse("$baseUrl/Personajes/Publicados/add"),
      
     headers: {"Content-Type": "application/json",
              "Authorization": "Bearer $token",
              },
     body: jsonEncode({"id": personaje.id}),
    );

    if(response.statusCode == 200)
     {

      
      directorioPersonajesPublicados.agregar(personaje);
      return true;
   

     }else
     {

      return false;
     }    
    
  }

  Future<String?> getAyudaHistoriaIA(BuildContext context, String historia) async {

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    final response = await http.post(Uri.parse("$baseUrl/IA/historia"),
      
     headers: {"Content-Type": "application/json",
              "Authorization": "Bearer $token",
              },
     body: jsonEncode({"historia": historia}),
    );

    if(response.statusCode == 200)
     {
      
      final data = jsonDecode(response.body);

      String historiaModificada = data["historia"];

      return historiaModificada;   

     }else
     {
      return null;

     }    
    
  }



  
  Future<bool?> cambiarFotoPersonaje(File? imagenFile, Uint8List? imagenBytes, BuildContext context, Personaje personaje) async {


    var request = http.MultipartRequest('POST',Uri.parse("$baseUrl/Personaje/ChangePhoto"),);
    
    

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['id'] = personaje.id.toString();    
    
    if (kIsWeb) {

      request.files.add(
      http.MultipartFile.fromBytes(
        'file', imagenBytes!, filename: 'foto.jpg', ),);
        
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('file',
          imagenFile!.path,),
          );
        }


    //Como es diferentes por los archivos se pone asi 

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = jsonDecode(response.body);

    if(response.statusCode == 200)
    {

      String fotoUrl = data["foto_url"];
      
      personaje.imagenUrl = fotoUrl;

      return true;

    }{

      return false;
    }
  }

}