import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/personaje.dart';

class PersonajeAddBasico extends StatefulWidget {
  final Personaje personaje;
  const PersonajeAddBasico({super.key, required this.personaje});

  @override
  State<PersonajeAddBasico> createState() => _PersonajeAddState();
}

class _PersonajeAddState extends State<PersonajeAddBasico> {

  late TextEditingController nombreController;
 // late TextEditingController claseController;
  late String? claseString;

  //late TextEditingController razaController;
  late String? razaString;

  //late TextEditingController trasfondoController;
  late String? transfondoString;

  //late TextEditingController alineamientoController;
  late String? alineamientoString;

  late TextEditingController nombreJugadorController;
  late TextEditingController historiaController;

  late TextEditingController fuerzaController;
  late TextEditingController destrezaController;
  late TextEditingController constitucionController;
  late TextEditingController inteligenciaController;
  late TextEditingController sabiduriaController;
  late TextEditingController carismaController;

  late TextEditingController claseArmaduraController;
  late TextEditingController puntosGolpeMaxController;

  late TextEditingController edadController;
  late TextEditingController alturaController;
  late TextEditingController pesoController;
  late TextEditingController ojosController;
  late TextEditingController peloController;
  late TextEditingController pielController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();  


    nombreController       = TextEditingController(text: widget.personaje.nombre);

    
    //claseController        = TextEditingController(text: widget.personaje.clase);
    claseString = widget.personaje.clase ?? "Guerrero";

    //razaController         = TextEditingController(text: widget.personaje.raza);
    razaString = widget.personaje.raza ?? "Humano";

    //trasfondoController    = TextEditingController(text: widget.personaje.trasfondo);
    transfondoString = widget.personaje.trasfondo ?? "Huerfano";

    //alineamientoController = TextEditingController(text: widget.personaje.alineamiento);
    alineamientoString = widget.personaje.alineamiento ?? "Neutral";

    nombreJugadorController= TextEditingController(text: widget.personaje.nombreJugador);
    historiaController     = TextEditingController(text: widget.personaje.historia);

    fuerzaController       = TextEditingController(text: widget.personaje.fuerza.toString());
    destrezaController     = TextEditingController(text: widget.personaje.destreza.toString());
    constitucionController = TextEditingController(text: widget.personaje.constitucion.toString());
    inteligenciaController = TextEditingController(text: widget.personaje.inteligencia.toString());
    sabiduriaController    = TextEditingController(text: widget.personaje.sabiduria.toString());
    carismaController      = TextEditingController(text: widget.personaje.carisma.toString());

    claseArmaduraController  = TextEditingController(text: widget.personaje.claseArmadura.toString());
    puntosGolpeMaxController = TextEditingController(text: widget.personaje.puntosGolpeMax.toString());

    edadController   = TextEditingController(text: widget.personaje.edad?.toString());
    alturaController = TextEditingController(text: widget.personaje.altura?.toString());
    pesoController   = TextEditingController(text: widget.personaje.peso?.toString());
    ojosController   = TextEditingController(text: widget.personaje.ojos);
    peloController   = TextEditingController(text: widget.personaje.pelo);
    pielController   = TextEditingController(text: widget.personaje.piel);    

  }

  //El dispose es para que al salir, se limpien los controllers, asi no se ralentiza la app 

  @override
  void dispose() {

    nombreController.dispose();

    nombreJugadorController.dispose();
    historiaController.dispose();

    fuerzaController.dispose();
    destrezaController.dispose();
    constitucionController.dispose();
    inteligenciaController.dispose();
    sabiduriaController.dispose();
    carismaController.dispose();

    claseArmaduraController.dispose();
    puntosGolpeMaxController.dispose();

    edadController.dispose();
    alturaController.dispose();
    pesoController.dispose();
    ojosController.dispose();
    peloController.dispose();
    pielController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        title: Text("Crear Personaje: Basico "),
        backgroundColor: AppConfig.colorAppBar,
      ),


      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
      
             //------Nombre-----
      
            TextFormField(
                  controller: nombreController,
                  validator: _validarCampoObligatorio,
      
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    label: Text("Nombre")
                    
                  ),
                ),
            
      /**
       *   late TextEditingController nombreController;
        late TextEditingController claseController;
        late TextEditingController razaController;
        late TextEditingController trasfondoController;
        late TextEditingController alineamientoController;
        late TextEditingController nombreJugadorController;
        late TextEditingController historiaController;
       */
      
            Row(
              children: [                        
                
                //Raza   
                 Row(
                   children: [
      
                     dropDown("Raza", razaString, ["Humano", "Elfo", "Enano", "Mediano"], 
                     (value) {setState(() => razaString = value!);}),
      
                     Tooltip(
                      message: _infoRaza[razaString] ?? "",
                      child: Icon(Icons.info_outline, color: Colors.blue),
                     )
      
      
                   ],
                 ),
      
                 SizedBox(width: 20,),
      
                 Row(
                   children: [
                     dropDown("Clase", claseString, ["Mago", "Picaro", "Artificiero", "Guerrero", "Clerico"], 
                     (value) {setState(() => claseString = value!);}),
      
                     Tooltip(
                      message: _infoClase[claseString] ?? "",
                      child: Icon(Icons.info_outline, color: Colors.blue),
                     )
      
      
                   ],
                 )
                    
      
              ],
            ),
      
            TextFormField(
                  controller: historiaController,                   
      
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    label: Text("Historia ")
                    
                  ),
                ),
      
      
      
      
          ],
      
      
      
      
      
        )),
    );
  }



  String? _validarCampoObligatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  void guardarCambios() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    
   
  

    if (true) {
      
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Registrado correctamente")),);

      Navigator.of(context).pop(true);

    } else{

    
    }

    
  }


  Widget dropDown(String label, String? value, List<String> opciones, ValueChanged<String?> onChanged) {

  return SizedBox(

    width: 250,
    child: DropdownButtonFormField<String>(

      value: value,
      decoration: InputDecoration(

        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    ),
  );
}

 final _infoRaza = {

    "Humano": "Versátiles y adaptables, +1 a todos los stats.",
    "Elfo": "Ágiles y longevos, ventaja en percepción.",
    "Enano": "Resistentes, resistencia al veneno.",
    "Mediano": "Pequeños y sigilosos, pueden retirar desventajas.",

  };

 final _infoClase = {

    "Mago": "Estudiosos de la magia arcana, aprenden hechizos mediante grimarios y la potencian con su inteligencia.",
    "Artificiero": "Inventores que combinan magia y tecnología, crean objetos mágicos y autómatas para apoyar al grupo.",
    "Guerrero":  "Maestros del combate, dominan todo tipo de armas y armaduras y aguantan más golpes que nadie.",
    "Picaro": "Expertos en sigilo y trampas, aprovechan los puntos débiles del enemigo para asestar golpes devastadores.",
    "Clerigo":   "Devotos de un dios que canalizan su poder divino para sanar aliados y destruir enemigos.",
  };

  void _mostrarInfo(BuildContext context, String titulo, String descripcion) {

  showDialog(
    context: context,

    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(descripcion),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cerrar"))
      ],
    ),
  );
}



}