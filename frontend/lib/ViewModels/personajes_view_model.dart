
import 'package:flutter/foundation.dart';
import 'package:heroforge/models/directorio_personajes.dart';
import 'package:http/http.dart' as http;

class PersonajeViewModel {

  late final String baseUrl;

  DirectorioPersonajes directorio;

  int get numPersonajes=> directorio.personajes.length; 

  //Si es andriid usa localHost (porque no tengo domain, si no pues el movil que es mi direccion IP )

  PersonajeViewModel(this.directorio, {String? androidIp} ) : baseUrl = kIsWeb
        ? "http://localhost:8000"
        : "http://${androidIp ?? '192.168.18.242'}:8000";






  void init() async 
  {

  }

  Future<bool?> cargarUsuarios() async 
  {
    final response = http.post(Uri.parse(""));





  }


}