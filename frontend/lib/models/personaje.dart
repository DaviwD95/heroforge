import 'package:flutter/material.dart';

class Personaje extends ChangeNotifier{


  //ESTO ES PROVISIONAL, ESTOY PENSANDO EN COMO ORGANIZARME BIEN Y SI ME FALTAN O NO COSAS 
  
  // Identificadores
  int? idPersonaje;
  int? idUsuario;

  // Datos básicos
  String? nombre;
  String? clase;
  String? raza;
  String? trasfondo;
  String? alineamiento;
  String? nombreJugador;

  int nivel;
  int puntosExperiencia;

  // Stats principales
  int fuerza;
  int destreza;
  int constitucion;
  int inteligencia;
  int sabiduria;
  int carisma;

  // Combate
  int claseDeArmadura;
  int puntosGolpeMaximos;

  // JSON fields
  Map<String, int> habilidades;  //Las secundarios es un json acuerdate pep

  List<Map<String, dynamic>> ataques;
  List<Map<String, dynamic>> hechizos;
  List<Map<String, dynamic>> inventario;

  List<String> rasgos;
  List<String> ideales;
  List<String> vinculos;
  List<String> defectos;

  // Físico
  int? edad;
  double? altura;
  double? peso;
  String? ojos;
  String? pelo;
  String? piel;

  DateTime? fechaCreacion;

  Personaje({
    this.idPersonaje,
    this.idUsuario,
    this.nombre,
    this.clase,
    this.raza,
    this.trasfondo,
    this.alineamiento,
    this.nombreJugador,
    this.nivel = 1,
    this.puntosExperiencia = 0,
    this.fuerza = 10,
    this.destreza = 10,
    this.constitucion = 10,
    this.inteligencia = 10,
    this.sabiduria = 10,
    this.carisma = 10,
    this.claseDeArmadura = 10,
    this.puntosGolpeMaximos = 10,
    Map<String, int>? habilidades,
    List<Map<String, dynamic>>? ataques,
    List<Map<String, dynamic>>? hechizos,
    List<Map<String, dynamic>>? inventario,
    List<String>? rasgos,
    List<String>? ideales,
    List<String>? vinculos,
    List<String>? defectos,
    this.edad,
    this.altura,
    this.peso,
    this.ojos,
    this.pelo,
    this.piel,
    this.fechaCreacion,
  })  : habilidades = habilidades ?? {},
        ataques = ataques ?? [],
        hechizos = hechizos ?? [],
        inventario = inventario ?? [],
        rasgos = rasgos ?? [],
        ideales = ideales ?? [],
        vinculos = vinculos ?? [],
        defectos = defectos ?? [];

  //  FROM JSON
  factory Personaje.fromJson(Map<String, dynamic> data) {
    return Personaje(
      idPersonaje: data["idPersonaje"],
      idUsuario: data["idUsuario"],
      nombre: data["nombre"],
      clase: data["clase"],
      raza: data["raza"],
      trasfondo: data["trasfondo"],
      alineamiento: data["alineamiento"],
      nombreJugador: data["nombreJugador"],
      nivel: data["nivel"] ?? 1,
      puntosExperiencia: data["puntosExperiencia"] ?? 0,
      fuerza: data["fuerza"] ?? 10,
      destreza: data["destreza"] ?? 10,
      constitucion: data["constitucion"] ?? 10,
      inteligencia: data["inteligencia"] ?? 10,
      sabiduria: data["sabiduria"] ?? 10,
      carisma: data["carisma"] ?? 10,
      claseDeArmadura: data["claseDeArmadura"] ?? 10,
      puntosGolpeMaximos: data["puntosGolpeMaximos"] ?? 10,
      habilidades: Map<String, int>.from(data["habilidades"] ?? {}),

      ataques: (data["ataques"] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],

      hechizos: (data["hechizos"] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],

      inventario: (data["inventario"] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],

      rasgos: List<String>.from(data["rasgos"] ?? []),
      ideales: List<String>.from(data["ideales"] ?? []),
      vinculos: List<String>.from(data["vinculos"] ?? []),
      defectos: List<String>.from(data["defectos"] ?? []),

      edad: data["edad"],
      altura: (data["altura"] as num?)?.toDouble(),
      peso: (data["peso"] as num?)?.toDouble(),
      ojos: data["ojos"],
      pelo: data["pelo"],
      piel: data["piel"],

      fechaCreacion: data["fechaCreacion"] != null
          ? DateTime.parse(data["fechaCreacion"])
          : null,
    );
  }

  //  TO JSON
  Map<String, dynamic> toJson() {
    return {
      if (idPersonaje != null) "idPersonaje": idPersonaje,
      "idUsuario": idUsuario,
      "nombre": nombre,
      "clase": clase,
      "raza": raza,
      "trasfondo": trasfondo,
      "alineamiento": alineamiento,
      "nombreJugador": nombreJugador,
      "nivel": nivel,
      "puntosExperiencia": puntosExperiencia,
      "fuerza": fuerza,
      "destreza": destreza,
      "constitucion": constitucion,
      "inteligencia": inteligencia,
      "sabiduria": sabiduria,
      "carisma": carisma,
      "claseDeArmadura": claseDeArmadura,
      "puntosGolpeMaximos": puntosGolpeMaximos,
      "habilidades": habilidades,
      "ataques": ataques,
      "hechizos": hechizos,
      "inventario": inventario,
      "rasgos": rasgos,
      "ideales": ideales,
      "vinculos": vinculos,
      "defectos": defectos,
      "edad": edad,
      "altura": altura,
      "peso": peso,
      "ojos": ojos,
      "pelo": pelo,
      "piel": piel,
      "fechaCreacion": fechaCreacion?.toIso8601String(),
    };
  }

  //  COPY WITH
  Personaje copyWith({
    int? idPersonaje,
    int? idUsuario,
    String? nombre,
    String? clase,
    String? raza,
    String? trasfondo,
    String? alineamiento,
    String? nombreJugador,
    int? nivel,
    int? puntosExperiencia,
    int? fuerza,
    int? destreza,
    int? constitucion,
    int? inteligencia,
    int? sabiduria,
    int? carisma,
    int? claseDeArmadura,
    int? puntosGolpeMaximos,
    Map<String, int>? habilidades,
    List<Map<String, dynamic>>? ataques,
    List<Map<String, dynamic>>? hechizos,
    List<Map<String, dynamic>>? inventario,
    List<String>? rasgos,
    List<String>? ideales,
    List<String>? vinculos,
    List<String>? defectos,
    int? edad,
    double? altura,
    double? peso,
    String? ojos,
    String? pelo,
    String? piel,
    DateTime? fechaCreacion,
  }) {
    return Personaje(
      idPersonaje: idPersonaje ?? this.idPersonaje,
      idUsuario: idUsuario ?? this.idUsuario,
      nombre: nombre ?? this.nombre,
      clase: clase ?? this.clase,
      raza: raza ?? this.raza,
      trasfondo: trasfondo ?? this.trasfondo,
      alineamiento: alineamiento ?? this.alineamiento,
      nombreJugador: nombreJugador ?? this.nombreJugador,
      nivel: nivel ?? this.nivel,
      puntosExperiencia: puntosExperiencia ?? this.puntosExperiencia,
      fuerza: fuerza ?? this.fuerza,
      destreza: destreza ?? this.destreza,
      constitucion: constitucion ?? this.constitucion,
      inteligencia: inteligencia ?? this.inteligencia,
      sabiduria: sabiduria ?? this.sabiduria,
      carisma: carisma ?? this.carisma,
      claseDeArmadura: claseDeArmadura ?? this.claseDeArmadura,
      puntosGolpeMaximos:
          puntosGolpeMaximos ?? this.puntosGolpeMaximos,
      habilidades: habilidades ?? Map.from(this.habilidades),
      ataques: ataques ?? List.from(this.ataques),
      hechizos: hechizos ?? List.from(this.hechizos),
      inventario: inventario ?? List.from(this.inventario),
      rasgos: rasgos ?? List.from(this.rasgos),
      ideales: ideales ?? List.from(this.ideales),
      vinculos: vinculos ?? List.from(this.vinculos),
      defectos: defectos ?? List.from(this.defectos),
      edad: edad ?? this.edad,
      altura: altura ?? this.altura,
      peso: peso ?? this.peso,
      ojos: ojos ?? this.ojos,
      pelo: pelo ?? this.pelo,
      piel: piel ?? this.piel,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  @override
  String toString() => toJson().toString();

  //  COPY FROM
  void copyFrom(Personaje otro) {
    idPersonaje = otro.idPersonaje;
    idUsuario = otro.idUsuario;
    nombre = otro.nombre;
    clase = otro.clase;
    raza = otro.raza;
    trasfondo = otro.trasfondo;
    alineamiento = otro.alineamiento;
    nombreJugador = otro.nombreJugador;
    nivel = otro.nivel;
    puntosExperiencia = otro.puntosExperiencia;
    fuerza = otro.fuerza;
    destreza = otro.destreza;
    constitucion = otro.constitucion;
    inteligencia = otro.inteligencia;
    sabiduria = otro.sabiduria;
    carisma = otro.carisma;
    claseDeArmadura = otro.claseDeArmadura;
    puntosGolpeMaximos = otro.puntosGolpeMaximos;
    habilidades = Map.from(otro.habilidades);
    ataques = List.from(otro.ataques);
    hechizos = List.from(otro.hechizos);
    inventario = List.from(otro.inventario);
    rasgos = List.from(otro.rasgos);
    ideales = List.from(otro.ideales);
    vinculos = List.from(otro.vinculos);
    defectos = List.from(otro.defectos);
    edad = otro.edad;
    altura = otro.altura;
    peso = otro.peso;
    ojos = otro.ojos;
    pelo = otro.pelo;
    piel = otro.piel;
    fechaCreacion = otro.fechaCreacion;
  }
}