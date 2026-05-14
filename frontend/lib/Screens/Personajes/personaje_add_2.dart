
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/personaje.dart';

class PersonajeAdd2 extends StatefulWidget {


  final Personaje personaje;
  const PersonajeAdd2({super.key, required this.personaje});

  @override
  State<PersonajeAdd2> createState() => _PersonajeAdd2State();
}

class _PersonajeAdd2State extends State<PersonajeAdd2> {

  //List<String> historialDados = [];

  //List<int> statsDados= [];
  //List<String> statsSeleccionables = ["15","14","13","12","10","8"];

  Map<String, int?> statsAsignadas = {


  'Fue': null, 'Des': null, 'Con': null,
  'Int': null, 'Sab': null, 'Car': null,


  };

  int dado1 = 0;
  int dado2  = 0;
  int dado3 = 0;
  int dado4  = 0;   

  late TextEditingController nivelController; 
  late TextEditingController puntosGolpeMaxController;
  late TextEditingController experienciaController;
  late TextEditingController claseArmaduraController; 


  late TextEditingController fueController;
  late TextEditingController desController;
  late TextEditingController conController;
  late TextEditingController intController;
  late TextEditingController sabController;
  late TextEditingController carController;
   
 

  final _formKey = GlobalKey<FormState>(); 


  @override
  void initState() {

    super.initState();    
      
    statsAsignadas = {
        'Fue': widget.personaje.fuerza,
        'Des': widget.personaje.destreza,
        'Con': widget.personaje.constitucion,
        'Int': widget.personaje.inteligencia,
       'Sab': widget.personaje.sabiduria,
        'Car': widget.personaje.carisma,
    };    

    puntosGolpeMaxController = TextEditingController(text: widget.personaje.puntosGolpeMax.toString());
    nivelController = TextEditingController(text: widget.personaje.nivel.toString());
    experienciaController = TextEditingController(text: widget.personaje.experiencia.toString());
    claseArmaduraController = TextEditingController(text: widget.personaje.claseArmadura.toString());

    fueController = TextEditingController(text: widget.personaje.fuerza.toString());
    desController = TextEditingController(text: widget.personaje.destreza.toString());
    conController = TextEditingController(text: widget.personaje.constitucion.toString());

    intController = TextEditingController(text: widget.personaje.inteligencia.toString());
    sabController = TextEditingController(text: widget.personaje.sabiduria.toString());
    carController = TextEditingController(text: widget.personaje.carisma.toString());

    //Habilidades

    // Habilidades — desde widget.personaje.habilidades (Map<String, int>)

    
  }

  @override
  void dispose() {    
    

    puntosGolpeMaxController.dispose();
    nivelController.dispose();
    experienciaController.dispose(); 

    fueController.dispose();
    desController.dispose();
    conController.dispose();
    intController.dispose();
    sabController.dispose();
    carController.dispose();

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar:  AppBar(
        title: Text("Crear Personaje: 2 "),
        backgroundColor: AppConfig.colorAppBar,
        actions: [
          TextButton(onPressed: ()
          {
            guardarCambios();

          }, child:Text("Continuar"))
        ],
      ),

      body: Form(
        key:  _formKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            //Como hago pars hacer que el texto este justificao, osea todo a la izquioerda? 

            Divider(color: Colors.blue, thickness: 6),

            Text("Estadisticas Base, Puntos de Golpe y Clase de Armadura", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
              
            Divider(color: Colors.blue, thickness: 6),

            SizedBox(height: 20),

            Text("Cada clase tiene unos puntos de golpe iniciales (tu vida al nivel 1) y una clase de armadura base (el número que el enemigo necesita sacar para golpearte). Además, cada vez que subes de nivel ganas puntos de golpe adicionales según tu clase.", 
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),textAlign: TextAlign.justify,),

          

            SizedBox(height: 10,),

            
            Row(
              children: [
                infoClase("Guerrero", "10", "6"),
                infoClase("Pícaro", "8", "5"),
              ],
            ),
            
            
            Row(
              children: [
                infoClase("Clérigo", "8", "5"),
                infoClase("Mago", "6", "4"),
              ],
            ),
      
            infoClase("Artificiero", "8", "5"),

            SizedBox(height: 15,),

            Text("Las estadísticas base no suben automáticamente al subir de nivel. A los niveles 4, 8, 12, 16 y 19 obtienes una Mejora de Característica: puedes subir 2 puntos a una stat o 1 punto a dos stats distintas. El Guerrero tiene mejoras adicionales en los niveles 6 y 14, y el Pícaro en el nivel 10.", 
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.justify,),



            SizedBox(height: 15),
  

            
            Divider(color: Colors.black, thickness: 5),

            SizedBox(height: 20),

            Row(
              children: [


                Expanded(child: campoIcono(Icons.favorite, Colors.red, puntosGolpeMaxController)),

                Expanded(child: campoIcono(Icons.shield_sharp, Colors.grey, claseArmaduraController )),

              ],
            ),


            Divider(color: Colors.black, thickness: 5),




            SizedBox(height: 25),

            Text("En D&D puedes elegir los valores de tus stats de dos formas: lanzar 4 dados de 6 y sumar los 3 más altos, repitiendo esto 6 veces para luego asignar cada resultado a una stat; o elegir directamente de la lista predeterminada [15, 14, 13, 12, 10, 8] asignando cada valor donde quieras.", 
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.justify,),

            SizedBox(height: 20),

            Text("Fuerza (FUE): potencia física — Destreza (DES): agilidad y reflejos — Constitución (CON): resistencia y vida — Inteligencia (INT): razonamiento y conocimiento — Sabiduría (SAB): percepción e intuición — Carisma (CAR): personalidad e influencia.",
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.justify,),
                       
            SizedBox(height: 20),

            Row(
              children: [

                SizedBox(width: 25),
                

                Expanded(child: campoNumero("Nivel", nivelController, Colors.grey.shade100,),),

                SizedBox(width: 25),

                Expanded(child: campoNumero( "Experiencia",experienciaController,Colors.grey.shade100,),
                ),
                
                SizedBox(width: 25),

                


              ],
            ),

            SizedBox(height: 20,),

            
             Text("Humano → +1 FUE  +1 DES  +1 CON  +1 INT  +1 SAB  +1 CAR | Elfo → +2 DES  | Enano → +2 CON  | Mediano → +2 DES ",
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.justify,),
                       
            SizedBox(height: 20),                  


            Row(
              
              children: [

                Expanded(child: campoStat("Fue", fueController)),                
                SizedBox(width: 10),
                  
                  
                Expanded(child: campoStat("Des", desController)),
                SizedBox(width: 10),
                
                Expanded(child: campoStat( "Con", conController)),
                SizedBox(width: 10),
              ],
            ),

            SizedBox(height: 20,),


            Row(
              children: [


              Expanded(child: campoStat("Int", intController)),
              SizedBox(width: 10),
              
              Expanded(child: campoStat("Sab", sabController)),
              SizedBox(width: 10),
              
              Expanded(child: campoStat("Car", carController)),
            ],),

            SizedBox(height: 40),     
            
            
            //Eleccion metodo, 4d6 (mayores  3 sumados) o escoger [15,14,13,12,10,8] sin repetir 
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
            
            
                Expanded(
                  child: Column(
                    children: [

                     // SizedBox(height: 9.5), 

                      Center(child: Image.asset('assets/dados/d6.png',width: 16,height: 16,),),
                              
                      ListTile(      
                        contentPadding: EdgeInsets.zero,             
                        title: Text(
                          "Método dados",
                          style: TextStyle(fontSize: 13),
                        ),
                        
                      ),
                              
                      Divider(color: Colors.black, thickness: 2),
                      
                      SizedBox(height: 15), //Lista de 6 dados, que al lanzalros abajo le sale su valor, 
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            children: [

                              IconButton(onPressed: () {
                                setState(() {
                                  dado1 = lanzarDado();                                   
                                  
                                });


                              }, icon: Image.asset('assets/dados/d6.png', width: 12, height: 12, fit: BoxFit.contain,)),

                              Text("$dado1"),
                            ],
                          ),


                          Column(
                            children: [

                              IconButton(onPressed: () {

                                setState(() {
                                  dado2 = lanzarDado();

                                   
                                });


                              }, icon: Image.asset('assets/dados/d6.png', width: 12, height: 12, fit: BoxFit.contain,)),

                              Text("$dado2"),
                            ],
                          ),

                                                                             
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            children: [

                              IconButton(onPressed: () {

                                setState(() {

                                  dado4= lanzarDado();
                                   
                                });


                              }, icon: Image.asset('assets/dados/d6.png', width: 12, height: 12, fit: BoxFit.contain,)),

                              Text("$dado4"),
                            ],
                          ),  

                          Column(
                            children: [

                              IconButton(onPressed: () {

                                setState(() {
                                  dado3= lanzarDado();

                                  
                                });


                              }, icon: Image.asset('assets/dados/d6.png', width: 12, height: 12, fit: BoxFit.contain,)),

                              Text("$dado3"),
                            ],
                          ),    
                        ],
                      ),

                      SizedBox(height: 10,),

                      Text(
                        dado1 > 0 && dado2 > 0 && dado3 > 0 && dado4 > 0
                            ? "→ ${([dado1, dado2, dado3, dado4]..sort()).sublist(1).reduce((a, b) => a + b)}"
                            : "Tira los 4 dados",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      

                      
                    ],
                  ),
                ),
                                  
                
                                  
                SizedBox(width: 15),


                
                Expanded(
                  child: Column(

                    
                    children: [

                      Center(child: Icon(Icons.data_array, size: 16,)),
                              
                      ListTile(
                        contentPadding: EdgeInsets.zero,  
                         
                        title: Text(
                          "Método Seleccion",
                          style: TextStyle(fontSize: 13),
                        ),
                        //trailing: Icon(Icons.data_array_outlined),
                      ),
                              
                      Divider(color: Colors.black, thickness: 2),
                      
                      SizedBox(height: 15),
                       
                      Text("[15,14,13,12,10,8]", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                              
                              
                    ],
                  ),
                ),
                                  
               
              ],
            ),
          ],
      
      
      
      
      
        )),



    );
  }


  void guardarCambios() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }


    widget.personaje.nivel = int.tryParse(nivelController.text) ?? 1;
    widget.personaje.experiencia = int.tryParse(experienciaController.text) ?? 0;

    widget.personaje.claseArmadura = int.tryParse(claseArmaduraController.text) ?? 10;
    widget.personaje.puntosGolpeMax = int.tryParse(puntosGolpeMaxController.text) ?? 10;

    widget.personaje.fuerza       = int.tryParse(fueController.text) ?? 10;
    widget.personaje.destreza     = int.tryParse(desController.text) ?? 10;
    widget.personaje.constitucion = int.tryParse(conController.text) ?? 10;
    widget.personaje.inteligencia = int.tryParse(intController.text) ?? 10;
    widget.personaje.sabiduria    = int.tryParse(sabController.text) ?? 10;
    widget.personaje.carisma      = int.tryParse(carController.text) ?? 10;

    Navigator.of(context).pop(widget.personaje);

    
  }


  Container campoStat( String stat, TextEditingController controller) {      


    int mod = (((int.tryParse(controller.text) ?? 0) - 10) / 2).floor();


    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding:  EdgeInsets.symmetric(horizontal: 14, vertical: 14),

      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),

      child: Column(
        children: [

          Text(stat, style: TextStyle(fontSize: 16)),

          SizedBox(height: 6),

          Text(
            "+ $mod",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple,),
          ),

          SizedBox(height: 5),          
          
          TextFormField(
            validator: validarNumeroObligatorio,
            controller: controller,              
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            
            onChanged:  (val) => setState(() {                 
             //  mod = (((int.tryParse(controller.text) ?? 0) - 10) / 2).floor();
            }),
          )          

        ],
      ),
          );
  }  
 
  int lanzarDado() {

      
    final rand = Random();
    int a = rand.nextInt(6) + 1;

    return a;

  }


  Widget infoClase(String nombre, String pg, String pgn) {

  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(10),
    
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
    
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nombre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.deepPurple)),
          Divider(height: 8, thickness: 0.5, color: Colors.deepPurple.shade200),

          Text("PG nivel 1: $pg + CON", style: TextStyle(fontSize: 12)),
          Text("PG por nivel: $pgn + CON", style: TextStyle(fontSize: 12)),
          Text("CA sin armadura: 10 + DES", style: TextStyle(fontSize: 12)),
        ],
      ),
    ),
  );
}



 
}