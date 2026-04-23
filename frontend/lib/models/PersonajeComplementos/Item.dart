class Item {
  int? id;
  String nombre;
  int cantidad;
  int peso;
  String descripcion;
 
  Item({
    this.id,
    required this.nombre,
    this.cantidad = 1,
    this.peso = 0,
    this.descripcion = "",
  });
 
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id:          json['id'],
        nombre:      json['nombre'],
        cantidad:    json['cantidad']    ?? 1,
        peso:        json['peso']        ?? 0,
        descripcion: json['descripcion'] ?? "",
      );
 
  Map<String, dynamic> toJson() => {

        'nombre':      nombre,
        'cantidad':    cantidad,
        'peso':        peso,
        'descripcion': descripcion,
        
      };
}