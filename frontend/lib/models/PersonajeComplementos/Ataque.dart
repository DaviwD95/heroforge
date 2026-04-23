class Ataque {
  int? id;
  String nombre;
  int bonus;
  String dano; // "1d6+3"
  String tipo; // cortante, contundente, fuego...
 
  Ataque({
    this.id,
    required this.nombre,
    this.bonus = 0,
    this.dano = "",
    required this.tipo,
  });
 
  factory Ataque.fromJson(Map<String, dynamic> json) => Ataque(
    
        id:     json['id'],
        nombre: json['nombre'],
        bonus:  json['bonus']  ?? 0,
        dano:   json['dano']   ?? "",
        tipo:   json['tipo']   ?? "",
      );
 
  Map<String, dynamic> toJson() => {

        'nombre': nombre,
        'bonus':  bonus,
        'dano':   dano,
        'tipo':   tipo,

      };
}
 