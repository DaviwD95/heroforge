

import 'package:flutter/material.dart';



import 'Personaje.dart';

class DirectorioPersonajes with ChangeNotifier {

  List<Personaje> _personajes;


  List<Personaje> get personajes => _personajes;


  DirectorioPersonajes([List<Personaje>? personajes])
      : _personajes = personajes ?? [];

  void agregar(Personaje personaje) {
    _personajes.add(personaje);
    notifyListeners();
  }  

  void eliminar(int i) {
    personajes.removeAt(i);
    notifyListeners();
  }

  void actualizar(int i, Personaje personaje) {
    personajes[i] = personaje;
    notifyListeners();
  }

  @override
  String toString() {
    return [
      "DirectorioPersonajes(",
      ..._personajes.map(
        (p) => p.toString().split("\n").map((e) => "\t$e").join("\n"),
      ),
      ")",
    ].join("\n");
  }
  

  List<Map<String, dynamic>> toJson() {
    return _personajes.map((p) => p.toJson()).toList();
  }

  factory DirectorioPersonajes.fromJson(List<Map<String, dynamic>> data) {
    return DirectorioPersonajes(
      data.map((p) => Personaje.fromJson(p)).toList(),
    );
  }

  void setPersonajes(List<Personaje> nuevos) {
  _personajes = nuevos;
  notifyListeners();
}

  // FILTROS UTILES
  

  List<Personaje> porClase(String clase) {
    return personajes.where((p) => p.clase == clase).toList();
  }

  List<Personaje> porRaza(String raza) {
    return personajes.where((p) => p.raza == raza).toList();
  }

  List<Personaje> nivelMayorA(int nivel) {
    return personajes.where((p) => p.nivel > nivel).toList();
  }

  



  

}