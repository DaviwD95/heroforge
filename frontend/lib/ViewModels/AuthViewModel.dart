import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/AppConfig.dart';
import 'package:heroforge/models/Auth/AuthProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Authviewmodel {

   final String baseUrl = AppConfig.baseUrl;

   Authviewmodel();


  //static const String baseUrlAndroid = "http://10.0.2.2:8000"; //esto es no es local, si tuviera dominio pues si
  //static const String baseUrl = "http://localhost:8000";


  Future<Map<String, dynamic>?> loginBack(String email, String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;

    }

    Future<bool> signBack(String email, String password, String fullName) async 
    {

      final response = await http.post(

        Uri.parse("$baseUrl/signin"),
        headers: {"Content-Type": "application/json"},
        body:  jsonEncode(
          {
            "email": email,
            "password" : password,
            "full_name" : fullName          
          }
          )
      );

      if (response.statusCode == 200)
      {
        return true;
      }else
      {

        return false;
      }
      
       //si es diferente a 200(salio bien) pues devuelve falso
    }

   
  Future<bool> rememberPasswordBack(String email) async { //enviar correo pues 

    try {

    final response = await http.post(
      Uri.parse("$baseUrl/remember-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    return response.statusCode == 200;

  } catch (e) {
    //asi cuando muestre el sbnack bar si aparecera    
    return false;

  }
  }


  Future<bool> resetPasswordBack(String token, String newPassword) async {

    final response = await http.post(
      Uri.parse("$baseUrl/reset-password"),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "token": token,
        "new_password": newPassword
      }
      ),
    );

    return response.statusCode == 200;
  } 


  
  
  Future<bool?> cambiarFotoUrl (File? imagenFile, Uint8List? imagenBytes, BuildContext context) async {


    var request = http.MultipartRequest('POST',Uri.parse("$baseUrl/Profile/ChangePhoto"),);
    
    

    final token = Provider.of<AuthProvider>(context, listen: false).token;

    request.fields['token'] = token!;
    
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

      Provider.of<AuthProvider>(context, listen: false).user!.fotoUrl =  fotoUrl;    
      
      Provider.of<AuthProvider>(context, listen: false).notifyListeners();

      return true;

    }{

      return false;
    }
  }

  Future<bool?> cambiarNombre(String nuevoNombre, BuildContext context) async 
  {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
   
    String? token = auth.token; 

    final response = await http.post(
    Uri.parse("$baseUrl/Profile/ChangeName"),
    headers: {
         "Content-Type": "application/json"
      },
    body: jsonEncode(
      {
        "token" : token,
        "nombre" :  nuevoNombre
      }
    )    
    );

    if(response.statusCode == 200)
    {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado el nombre con exito")),);
     auth.user!.nombre = nuevoNombre;
     auth.notifcar();

    }else
    {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal en el cambio de nombre")),);
    }
  }

  Future<bool?> cambiarEmail(String nuevoEmail, BuildContext context) async 
  {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    String? token= auth.token; 

    final response = await http.post(
    Uri.parse("$baseUrl/Profile/ChangeEmail"),
    headers: {
         "Content-Type": "application/json"
      },
    body: jsonEncode(
      {
        "token" : token,
        "email" : nuevoEmail,       
      }
    )    
    );

    if(response.statusCode == 200)
    {
      //Sacamos el token nuevo y lo asignamos 
     final data = jsonDecode(response.body);
     String tokenNuevo = data["access_token"];

     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado el email con exito")),);

     auth.user!.email = nuevoEmail;
     auth.token = tokenNuevo;

     auth.notifcar();

    }else
    {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal en el cambio de email")),);
    }
  }

}