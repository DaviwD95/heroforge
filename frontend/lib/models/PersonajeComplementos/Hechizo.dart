class Hechizo {
  int? id;
  String nombre;
  int nivel;       // 0 = truco
  String escuela;  // Evocación, Ilusión...
  String? descripcion;
 
  Hechizo({
    this.id,
    required this.nombre,
    this.nivel = 0,
    this.escuela = "",
    this.descripcion,
  });
 
  factory Hechizo.fromJson(Map<String, dynamic> json) => Hechizo(
    
        id:          json['id'],
        nombre:      json['nombre'],
        nivel:       json['nivel']   ?? 0,
        escuela:     json['escuela'] ?? "",
        descripcion: json['descripcion'],
      );
 
  Map<String, dynamic> toJson() => {

        'nombre':      nombre,
        'nivel':       nivel,
        'escuela':     escuela,
        'descripcion': descripcion,

      };
}