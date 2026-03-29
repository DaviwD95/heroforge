import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Authviewmodel {

  late final String baseUrl;

   Authviewmodel({String? androidIp})
    : baseUrl = kIsWeb
        ? "http://localhost:8000"
        : "http://${androidIp ?? '192.168.18.242'}:8000";

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

}