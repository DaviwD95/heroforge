class Usuario {

    //Se que en el token ya van el rol y el email, pero es mas por tenero a mano en uusuario y poder acceder a el facil pues
  int id; 
  String email; 
  String nombre;
  String role;
  String? fotoUrl;
  

  Usuario({required this.id, required this.nombre, required this.role, required this.email, this.fotoUrl});


  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(

      id: json["id"],
      email: json['email'],
      nombre: json['full_name'],
      fotoUrl : json['foto_url'],
      role: json['role'],
      

    );
  }

  Usuario copyWith({
    int? id,
    String? nombre,
    String? email,
    String? role,
    String? fotoUrl,
  }) {
    return Usuario(

      id : id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      role: role ?? this.role,      
      fotoUrl: fotoUrl ?? this.fotoUrl,
    );
  }


   
  }