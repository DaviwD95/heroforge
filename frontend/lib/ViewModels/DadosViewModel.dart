import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/Auth/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

//Este no lo meti en el provider, no lo vi necesario, solo hace falta para la peticion del backend a la API de datos de numeros

class Dadosviewmodel {

  final String baseUrl = AppConfig.baseUrl;

  Dadosviewmodel();


  Future<String?> getDato(BuildContext context) async 
  {

    final token = Provider.of<AuthProvider>(context, listen: false).token;


    final response = await http.get(Uri.parse("$baseUrl/getDatoCurioso"), 
     headers: {"Authorization": "Bearer $token"},);
  

    if(response.statusCode == 200)
    {

      final data = jsonDecode(response.body);
      final fraseEs = data["frase"];

      final translator = GoogleTranslator();
      final traduccion = await translator.translate(fraseEs, to: 'es');

      return traduccion.text;
      
    }else
    {
      return "";
    }    
  }




}