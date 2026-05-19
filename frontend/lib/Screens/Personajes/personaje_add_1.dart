
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonajeAdd1 extends StatefulWidget {
  final Personaje personaje;
  const PersonajeAdd1({super.key, required this.personaje});

  @override
  State<PersonajeAdd1> createState() => _PersonajeAddState();
}

class _PersonajeAddState extends State<PersonajeAdd1> {

  

  late PersonajeViewModel vm;

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

  late TextEditingController rasgosController;
  late TextEditingController idealesController;
  late TextEditingController vinculosController;
  late TextEditingController defectosController;

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

  Color colorAspectoFisico = Colors.orange[100]!;

  Color colorBasico = Colors.grey.shade100;



  @override
  void initState() {
    super.initState();  
    
    vm = Provider.of<PersonajeViewModel>(context, listen: false);

    nombreController = TextEditingController(text: widget.personaje.nombre ?? "");

    nombreJugadorController= TextEditingController(text: widget.personaje.nombreJugador ?? "");

    
    //claseController        = TextEditingController(text: widget.personaje.clase);
    claseString = widget.personaje.clase ?? "Guerrero";

    //razaController         = TextEditingController(text: widget.personaje.raza);
    razaString = widget.personaje.raza ?? "Humano";

    //trasfondoController    = TextEditingController(text: widget.personaje.trasfondo);
    transfondoString = widget.personaje.trasfondo ?? "Huérfano";

    //alineamientoController = TextEditingController(text: widget.personaje.alineamiento);
    alineamientoString = widget.personaje.alineamiento ?? "Neutral";

    
    historiaController     = TextEditingController(text: widget.personaje.historia);

    edadController = TextEditingController(text: widget.personaje.edad?.toString());
    alturaController = TextEditingController(text: widget.personaje.altura?.toString());
    pesoController = TextEditingController(text: widget.personaje.peso?.toString());
    ojosController = TextEditingController(text: widget.personaje.ojos ?? "");
    peloController = TextEditingController(text: widget.personaje.pelo ?? "");
    pielController = TextEditingController(text: widget.personaje.piel ?? "");

    //Traits (s) / Caracteristicas
    
    rasgosController = TextEditingController(text: widget.personaje.rasgos ?? "");
    idealesController = TextEditingController(text: widget.personaje.ideales ?? "");
    vinculosController = TextEditingController(text: widget.personaje.vinculos ?? "");
    defectosController = TextEditingController(text: widget.personaje.defectos ?? "");
   


    //Habilidades


    claseArmaduraController = TextEditingController(text: widget.personaje.claseArmadura.toString());
    puntosGolpeMaxController = TextEditingController(text: widget.personaje.puntosGolpeMax.toString());


    /**
     *   List<String> rasgos;
  List<String> ideales;
  List<String> vinculos;
  List<String> defectos;
     */
   

  }

  //El dispose es para que al salir, se limpien los controllers, asi no se ralentiza la app 

  @override
  void dispose() {

    nombreController.dispose();

    nombreJugadorController.dispose();
    historiaController.dispose();

    
    edadController.dispose();
    alturaController.dispose();
    pesoController.dispose();
    ojosController.dispose();
    peloController.dispose();
    pielController.dispose();

    rasgosController.dispose();
    idealesController.dispose();
    vinculosController.dispose();
    defectosController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar:  AppBar(
        title: Text("Crear Personaje: 1 "),
        backgroundColor: AppConfig.colorAppBar,

        actions: [

          TextButton(onPressed: guardarCambios, child: Text("Continuar"))
        ],
      ),


      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [

            
            Divider(color: Colors.blue, thickness: 6),

            Text("Básico", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
      
            Divider(color: Colors.blue, thickness: 6),

            SizedBox(height: 20),

            Row(
              children: [
                
                Expanded(child: campo("Nombre del Personaje", nombreController,colorBasico, obligatorio: true)),

                SizedBox(width: 30),

                Expanded(child: campo("Nombre del Jugador", nombreJugadorController, colorBasico, obligatorio: false))

              ],
            ),

            SizedBox(height: 20),
            
    
      
            Row(
              children: [                        
                
                //Raza   
                 Expanded(
                   child: dropDown("Raza", razaString, ["Humano", "Elfo", "Enano", "Mediano"], 
                   (value) {setState(() => razaString = value);}),
                 ),
                       
                 Tooltip(
                  message: _infoRaza[razaString] ?? "",
                  child: Icon(Icons.info_outline, color: Colors.blue),
                 ),
      
                 SizedBox(width: 20,),
                 
                //Clase 
                 Expanded(
                   child: dropDown("Clase", claseString, ["Mago", "Picaro", "Artificiero", "Guerrero", "Clerigo"], 
                   (value) {setState(() => claseString = value);}),
                 ),
                       
                 Tooltip(
                  message: _infoClase[claseString] ?? "",
                  child: Icon(Icons.info_outline, color: Colors.blue),
                 )
                    
      
              ],
            ),

            SizedBox(height: 20,),
            //Historia + alineamiento y transfondo            

            SizedBox(

              height: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Historia
                  

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      minLines: null, 
                      style: TextStyle(fontWeight: FontWeight.bold),                     
                      controller: historiaController,       
                      textAlignVertical: TextAlignVertical.top,             
                    
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorBasico,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:  BorderSide(color: Color(0xFF6C63FF), width: 2),
                          ),

                        suffixIcon: IconButton(
                          icon: Icon(Icons.auto_awesome, color: Colors.deepPurple),
                          tooltip: "Pedir ayuda...",
                          onPressed: pedirAyudaHistoria,
                        ),

                        label: Text("Historia"),
                      ),
                    ),
                  ),

                  SizedBox(width: 12,),
                  

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [

                        SizedBox(height: 70),

                        

                        Row(
                          children: [

                            //Alineamiento

                            Expanded(
                              child: dropDown(
                                "Alineamiento",alineamientoString,
                                ["Legal Bueno", "Neutral Bueno", "Caótico Bueno",
                                "Legal Neutral", "Neutral", "Caótico Neutral",
                                "Legal Malvado", "Neutral Malvado", "Caótico Malvado"],
                                (value) { setState(() => alineamientoString = value); },
                              ),
                            ),

                            Tooltip(message: "El Alineamiento es como se comportara tu personaje/ sus valores",
                            child: Icon(Icons.info_outline, color: Colors.blue),)
                          ],
                        ),

                        SizedBox(height: 40),

                        Row(
                          children: [

                            Expanded(
                              child: dropDown("Transfondo", transfondoString, ["Huérfano","Soldado", "Marinero", "Criminal", "Héroe del Pueblo"],
                               (value) { setState(() => transfondoString = value); },),
                            ),

                           // Tooltip(message: _infoTransfondo[transfondoString].toString(),
                            //child: Icon(Icons.info_outline, color: Colors.blue),)
                          ],
                        )


                      ],
                  ))
                ],                 
                ),
            ),

            SizedBox(height: 20),
         
       

            //Datos Fisicos

            
            Divider(color: Colors.red, thickness: 6),

            Text("Aspecto Físico", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
      
            Divider(color: Colors.red, thickness: 6),

            SizedBox(height: 20,),
            
            

            Row(
              children: [
                //Edad
                Expanded(child: campoNumero("Edad", edadController, colorAspectoFisico,obligatorio: false)),

                SizedBox(width: 15),

                //Altura
                Expanded(child: campoDouble("Altura (metros)", alturaController, colorAspectoFisico,obligatorio: false)),

                SizedBox(width: 15),

                //peso
                Expanded(child: campoDouble("Peso (kg)", pesoController, colorAspectoFisico,obligatorio: false))

                ],
            ),

            SizedBox(height: 20),

            Row(
              children: [


              //Edad
                Expanded(child: campo("Ojos (Color)", ojosController, colorAspectoFisico, obligatorio: false)),

                SizedBox(width: 15),

                //Altura
                Expanded(child: campo("Pelo (Color)", peloController, colorAspectoFisico, obligatorio: false)),

                SizedBox(width: 15),

                //peso
                Expanded(child: campo("Piel (Color)", pielController, colorAspectoFisico, obligatorio: false))

             ],),

             SizedBox(height: 20),

             Divider(color: Colors.green, thickness: 6),

             Text("Personalidad", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
      
             Divider(color: Colors.green, thickness: 6),

             SizedBox(height: 20),

             

             SizedBox(
              height: 200,
               child: Row(
                children: [
                  //Rasgos

                  Expanded(
                    flex: 1,
                    child: TextFormField(                      
                      expands: true,
                      maxLines: null,
                      style:TextStyle(fontWeight: FontWeight.bold),
                      minLines: null,                      
                      controller: rasgosController,       
                      textAlignVertical: TextAlignVertical.top,             
                    
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Rasgos"),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      minLines: null,     
                      style: TextStyle(fontWeight: FontWeight.bold),                 
                      controller: idealesController,       
                      textAlignVertical: TextAlignVertical.top,             
                    
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Ideales"),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      minLines: null,        
                      style: TextStyle(fontWeight: FontWeight.bold),              
                      controller: vinculosController,       
                      textAlignVertical: TextAlignVertical.top,             
                    
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("vinculos"),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      expands: true,
                      maxLines: null,
                      minLines: null,                      
                      controller: defectosController,       
                      textAlignVertical: TextAlignVertical.top,             
                    
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Defectos"),
                      ),
                    ),
                  ),       
                  
                ],
               ),
             )      
          ],      
        )),
    );
  }


  

  void guardarCambios() async {

    if (!_formKey.currentState!.validate()) {
      return;
    } 



   // widget.personaje.idUsuario = 
    widget.personaje.nombre        = nombreController.text.trim();
    widget.personaje.nombreJugador = nombreJugadorController.text.trim();
    widget.personaje.clase         = claseString;
    widget.personaje.raza          = razaString;
    widget.personaje.trasfondo     = transfondoString;
    widget.personaje.alineamiento  = alineamientoString;
    widget.personaje.historia      = historiaController.text.trim();

    widget.personaje.edad    = int.tryParse(edadController.text);
    widget.personaje.altura  = double.tryParse(alturaController.text);
    widget.personaje.peso    = double.tryParse(pesoController.text);
    widget.personaje.ojos    = ojosController.text.trim();
    widget.personaje.pelo    = peloController.text.trim();
    widget.personaje.piel    = pielController.text.trim();

    widget.personaje.rasgos   = rasgosController.text.trim();
    widget.personaje.ideales  = idealesController.text.trim();
    widget.personaje.vinculos = vinculosController.text.trim();
    widget.personaje.defectos = defectosController.text.trim();

    widget.personaje.claseArmadura  = int.tryParse(claseArmaduraController.text) ?? 0;
    widget.personaje.puntosGolpeMax = int.tryParse(puntosGolpeMaxController.text) ?? 0;

    Navigator.of(context).pop(widget.personaje);
    
  } 



 final _infoRaza = {

    "Humano": "Versátiles y adaptables, +1 a todos los stats.",
    "Elfo": "Ágiles y longevos, ventaja en percepción.",
    "Enano": "Resistentes, resistencia al veneno.",
    "Mediano": "Pequeños y sigilosos, pueden retirar desventajas.",

  };

 final _infoClase = {

    "Mago": "Estudiosos de la magia arcana, aprenden hechizos mediante grimorios y lo potencian con su inteligencia.",
    "Artificiero": "Inventores que combinan magia y tecnología, crean objetos mágicos y autómatas para apoyar al grupo.",
    "Guerrero":  "Maestros del combate, dominan todo tipo de armas y armaduras y aguantan más golpes que nadie.",
    "Picaro": "Expertos en sigilo y trampas, aprovechan los puntos débiles del enemigo para asestar golpes devastadores.",
    "Clerigo":   "Devotos de un dios que canalizan su poder divino para sanar aliados y destruir enemigos.",
  };

 // ignore: slash_for_doc_comments
 /**
  * final _infoTransfondo = {

  "Huérfano": {
    "competencias_hab": ["Engaño", "Sigilo"],
    "competencias_herr": ["Herramientas de ladrón"],
    "idiomas": [],
    "items": ["Palanca", "Ropa oscura con capucha", "Bolsa con 15 gp"],
  },

  "Soldado": {
    "competencias_hab": ["Atletismo", "Intimidación"],
    "competencias_herr": ["Dados de hueso", "Vehículos (tierra)"],
    "idiomas": [],
    "items": ["Insignia de rango", "Trofeo de enemigo caído", "Ropa común", "Bolsa con 10 gp"],
  },

  "Criminal": {
    "competencias_hab": ["Engaño", "Sigilo"],
    "competencias_herr": ["Herramientas de ladrón", "Dados de hueso"],
    "idiomas": [],
    "items": ["Palanca", "Ropa oscura con capucha", "Bolsa con 15 gp"],
  },
  "Marinero": {
    "competencias_hab": ["Atletismo", "Percepción"],
    "competencias_herr": ["Herramientas de navegante", "Vehículos (agua)"],
    "idiomas": [],
    "items": ["Garrote", "Soga (50 pies)", "Amuleto de la suerte", "Ropa común", "Bolsa con 10 gp"],
  },

  "Héroe del Pueblo": {
    "competencias_hab": ["Manejo de animales", "Supervivencia"],
    "competencias_herr": ["Herramientas de carpintero", "Vehículos (tierra)"],
    "idiomas": [],
    "items": ["Pala", "Olla de hierro", "Ropa común", "Bolsa con 10 gp"],
  },

 };
  */




  void pedirAyudaHistoria() async {



    String? historiaModificada = await vm.getAyudaHistoriaIA(context, historiaController.text);

   if (historiaModificada != null)
   {

     historiaController.text = historiaModificada;
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Groq logro acudir a tu rescate",),),);
                                 
   }else
   { 
     Random random = Random();

     int numero = random.nextInt(2);
     if(numero == 1)
     {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Parece que Groq ha caido en comnbate....",),),); 
     }else
     {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pero nadie vino.....",),),); 
     }                            


   }
 }

 




}