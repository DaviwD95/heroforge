import 'package:flutter/material.dart';
import 'package:heroforge/models/PersonajeComplementos/ataque.dart';
import 'package:heroforge/models/PersonajeComplementos/Hechizo.dart';
import 'package:heroforge/models/PersonajeComplementos/Item.dart';

class Personaje extends ChangeNotifier {

  //Datos basicos del personaje 

  int?    id;
  int?    idUsuario;
  String? nombre;
  String? clase;
  String? raza;
  String? trasfondo;
  String? alineamiento;

  String? nombreJugador;
  String? historia;
  int? nivel;
  int? experiencia;
  bool? publicado;
  DateTime? fechaCreacion; //auto 

  // Stats

  int fuerza;
  int destreza;
  int constitucion;
  int inteligencia;
  int sabiduria;
  int carisma;

  // Combate

  int claseArmadura;
  int puntosGolpeMax;

  // Apariencia

  int?    edad;
  double? altura;
  double? peso;
  String? ojos;
  String? pelo;
  String? piel;
  String? imagenUrl;

  // Personalidad

  String? rasgos;
  String? ideales;
  String? vinculos;
  String? defectos;

  //Habilidades secundarias 

  Map<String, int> habilidades;

  // Listas (tablas separadas en backend) 

  List<Ataque>?  ataques;
  List<Hechizo>? hechizos;
  List<Item>?    inventario;

  Personaje({
    this.id,
    this.idUsuario,
    this.nombre,
    this.clase,
    this.raza,
    this.trasfondo,
    this.alineamiento,
    this.nombreJugador,
    this.historia,
    this.nivel        = 1,
    this.experiencia  = 0,
    this.publicado    = false,
    this.fechaCreacion,
    this.fuerza       = 10,
    this.destreza     = 10,
    this.constitucion = 10,
    this.inteligencia = 10,
    this.sabiduria    = 10,
    this.carisma      = 10,
    this.claseArmadura  = 10,
    this.puntosGolpeMax = 10,
    this.edad,
    this.altura,
    this.peso,
    this.ojos,
    this.pelo,
    this.piel,
    this.imagenUrl,
    this.rasgos,
    this.ideales,
    this.vinculos,
    this.defectos,    
    Map<String, int>? habilidades,
    List<Ataque>?  ataques,
    List<Hechizo>? hechizos,
    List<Item>?    inventario,
  })  : 
        habilidades = habilidades ?? {},
        ataques     = ataques     ?? [],
        hechizos    = hechizos    ?? [],
        inventario  = inventario ?? []; 


  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
        id:            json['id'],
        idUsuario:     json['id_usuario'],
        nombre:        json['nombre'],
        clase:         json['clase'],
        raza:          json['raza'],
        trasfondo:     json['trasfondo'],
        alineamiento:  json['alineamiento'],
        nombreJugador: json['nombre_jugador'],
        historia:      json['historia'],
        nivel:         json['nivel']       ?? 1,
        experiencia:   json['experiencia'] ?? 0,
        publicado:     json['publicado']   ?? false,
        fechaCreacion: json['fecha_creacion'] != null ? DateTime.parse(json['fecha_creacion']) : null,

        // Stats
        fuerza:       json['fuerza']       ?? 10,
        destreza:     json['destreza']     ?? 10,
        constitucion: json['constitucion'] ?? 10,
        inteligencia: json['inteligencia'] ?? 10,
        sabiduria:    json['sabiduria']    ?? 10,
        carisma:      json['carisma']      ?? 10,

        // Combate
        claseArmadura:  json['clase_armadura']   ?? 10,
        puntosGolpeMax: json['puntos_golpe_max'] ?? 10,

        // Apariencia
        edad:      json['edad'],
        altura:    (json['altura'] as num?)?.toDouble(),
        peso:      (json['peso']   as num?)?.toDouble(),
        ojos:      json['ojos'],
        pelo:      json['pelo'],
        piel:      json['piel'],
        imagenUrl: json['imagen_url'],

        // Personalidad
        rasgos:   json['rasgos'],
        ideales:  json['ideales'],
        vinculos: json['vinculos'],
        defectos: json['defectos'],

        // Habilidades
        habilidades: Map<String, int>.from(json['habilidades'] ?? {}),

        // Listas
        ataques:   (json['ataques']    as List?)?.map((e) => Ataque.fromJson(e)).toList()  ?? [],
        hechizos:  (json['hechizos']   as List?)?.map((e) => Hechizo.fromJson(e)).toList() ?? [],
        inventario: (json['inventario'] as List?)?.map((e) => Item.fromJson(e)).toList()   ?? [],
      );

 
  Map<String, dynamic> toJson() => {

        "id":           id,
        "id_usuario":   idUsuario,
        "nombre":       nombre,
        "clase":        clase,
        "raza":         raza,
        "trasfondo":    trasfondo,
        "alineamiento": alineamiento,
        "nombre_jugador": nombreJugador,
        "historia":     historia,
        "nivel":        nivel,
        "experiencia":  experiencia,
        "publicado":    publicado,
        "fecha_creacion": fechaCreacion?.toIso8601String(),

        // Stats

        "fuerza":       fuerza,
        "destreza":     destreza,
        "constitucion": constitucion,
        "inteligencia": inteligencia,
        "sabiduria":    sabiduria,
        "carisma":      carisma,

        // Combate

        "clase_armadura":   claseArmadura,
        "puntos_golpe_max": puntosGolpeMax,

        // Apariencia

        "edad":      edad,
        "altura":    altura,
        "peso":      peso,
        "ojos":      ojos,
        "pelo":      pelo,
        "piel":      piel,
        "imagen_url": imagenUrl,

        // Personalidad

        "rasgos":   rasgos,
        "ideales":  ideales,
        "vinculos": vinculos,
        "defectos": defectos,

        // Habilidades

        "habilidades": habilidades,

        // Listas

        "ataques":    ataques?.map((e)    => e.toJson()).toList(),
        "hechizos":   hechizos?.map((e)   => e.toJson()).toList(),
        "inventario": inventario?.map((e) => e.toJson()).toList(),
      };


  
  String? get claseBase => clase?.split('/').first;
  String? get subclase  => clase!.split('/').length > 1  ? clase?.split('/').last : null;
  

  // Fórmula para modificadores: (stat - 10) / 2 redondeado hacia abajo
  
  int modificador(int stat) => ((stat - 10) / 2).floor();
  int get bonusCompetencia => ((nivel! - 1) ~/ 4) + 2;

  int get modFuerza       => modificador(fuerza);
  int get modDestreza     => modificador(destreza);
  int get modConstitucion => modificador(constitucion);
  int get modInteligencia => modificador(inteligencia);
  int get modSabiduria    => modificador(sabiduria);
  int get modCarisma      => modificador(carisma);

  int get iniciativa => modDestreza;


  int? get velocidad {

    if(raza == "Enano" || raza == "Mediano")
    {
      return 25; //Esto es en pies, son 7.5 metros
    }else if(raza == "Humano" || raza == "Elfo")
    {
      return 30; //Esto es en pies, son 9
    }else
    {
      return null;
    }
    
    
   
}

  //Calcular el modHabilidad(incluso con el  bono comp)

  int modHabilidad(String hab) {
    

    final stats = {
      
     'acrobacias': modDestreza,     'atletismo': modFuerza,
     'C.arcano': modInteligencia,   'engano': modCarisma,
     'historia': modInteligencia,   'interpretacion': modCarisma,
     'intimidacion': modCarisma,    'investigacion': modInteligencia,
     'juegoDeManos': modDestreza,   'medicina': modSabiduria,
     'naturaleza': modInteligencia, 'percepcion': modSabiduria,
     'perspicacia': modSabiduria,   'persuasion': modCarisma,
     'religion': modInteligencia,   'sigilo': modDestreza,
     'supervivencia': modSabiduria, 'tratoAnimales': modSabiduria,
     };

    final compClase = {
      

     'Mago':        ['C.arcano', 'historia', 'investigacion', 'medicina', 'religion', 'perspicacia'],
     'Artificiero': ['C.arcano', 'historia', 'investigacion', 'medicina', 'naturaleza', 'percepcion'],
     'Guerrero':    ['atletismo', 'intimidacion', 'supervivencia', 'percepcion', 'historia', 'acrobacias'],
     'Picaro':      ['acrobacias', 'engano', 'perspicacia', 'intimidacion', 'investigacion', 'sigilo', 'juegoDeManos', 'persuasion'],
     'Clerigo':     ['historia', 'medicina', 'persuasion', 'religion', 'perspicacia', 'intimidacion'],
   };

    bool tieneComp = (compClase[claseBase] ?? []).contains(hab);

    return (stats[hab] ?? 0) + (tieneComp ? bonusCompetencia : 0);
  }

  bool tieneCompHabilidad(String hab) {
    
    final compClase = {

     'Mago':        ['C.arcano', 'historia', 'investigacion', 'medicina', 'religion', 'perspicacia'],
     'Artificiero': ['C.arcano', 'historia', 'investigacion', 'medicina', 'naturaleza', 'percepcion'],
     'Guerrero':    ['atletismo', 'intimidacion', 'supervivencia', 'percepcion', 'historia', 'acrobacias'],
     'Picaro':      ['acrobacias', 'engano', 'perspicacia', 'intimidacion', 'investigacion', 'sigilo', 'juegoDeManos', 'persuasion'],
     'Clerigo':     ['historia', 'medicina', 'persuasion', 'religion', 'perspicacia', 'intimidacion'],
    };

    return (compClase[claseBase] ?? []).contains(hab);

  }

//PAra las tiradas de salvacion

  int modSalvacion(String stat) {

    final compSalv = {

      'Guerrero': ['FUE', 'CON'],
      'Picaro': ['DES', 'INT'],
      'Clerigo': ['SAB', 'CAR'],
      'Mago': ['INT', 'SAB'],
      'Artificiero': ['CON', 'INT'],
    };

    final bases = {
      'FUE': modFuerza,
      'DES': modDestreza,
      'CON': modConstitucion,
      'INT': modInteligencia,
      'SAB': modSabiduria,
      'CAR': modCarisma,

    };

    final base = bases[stat] ?? 0;

    final tieneComp = (compSalv[claseBase] ?? []).contains(stat);
    return base + (tieneComp ? bonusCompetencia : 0);

  }

  bool tieneCompSalvacion(String stat) {

    final compSalv = {

      'Guerrero': ['FUE', 'CON'],
      'Picaro': ['DES', 'INT'],
      'Clerigo': ['SAB', 'CAR'],
      'Mago': ['INT', 'SAB'],
      'Artificiero': ['CON', 'INT'],

    };
    return (compSalv[claseBase] ?? []).contains(stat);

  }

  String statDeHabilidad(String hab) {

  final deps = {
    'acrobacias': 'DES',     'atletismo': 'FUE',
    'C.arcano': 'INT',       'engano': 'CAR',
    'historia': 'INT',       'interpretacion': 'CAR',
    'intimidacion': 'CAR',   'investigacion': 'INT',
    'juegoDeManos': 'DES',   'medicina': 'SAB',
    'naturaleza': 'INT',     'percepcion': 'SAB',
    'perspicacia': 'SAB',    'persuasion': 'CAR',
    'religion': 'INT',       'sigilo': 'DES',
    'supervivencia': 'SAB',  'tratoAnimales': 'SAB',
  };
  
  return deps[hab] ?? hab;
}

  
}