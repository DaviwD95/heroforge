import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/personaje.dart';


class DetallesPersoonaje extends StatelessWidget {
  
  final Personaje personaje;
  const DetallesPersoonaje({super.key, required this.personaje});

  

  @override
  Widget build(BuildContext context) {

    Color colorBasico = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        title: Text("Detalles: ${personaje.nombre}"),
        backgroundColor: colorSegunClase(personaje),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
        
          children: [

            //Basico
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Nombre Personaje", TextEditingController(text: personaje.nombre), colorBasico, readOnly: true)),
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Nombre del jugador", TextEditingController(text: personaje.nombreJugador), colorBasico, readOnly: true)),
        
                SizedBox(width: 20),
              ],
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [

                Flexible(
                  child: Column(
                    children: [
                  
                      campo("Clase", TextEditingController(text: personaje.claseBase), colorBasico, readOnly: true),
                  
                      SizedBox(height: 10),
                  
                      Image.asset(imagenSegunClase(personaje.claseBase), width: 80, height: 85),
                    ],
                  ),
                ),

                SizedBox(width: 16),

                Flexible(
                  child: Column(
                    
                    children: [
                  
                      campo("Raza", TextEditingController(text: personaje.raza), colorBasico, readOnly: true),
                  
                      SizedBox(height: 10),
                  
                      Image.asset(imagenSegunRaza(personaje.raza), width: 80, height: 85),
                    ],
                  ),
                ),

                SizedBox(width: 16),
                
                Flexible(child: campoIcono(Icons.favorite, Colors.red, TextEditingController(text: personaje.puntosGolpeMax.toString()), size: 80, readOnly: true)),

                SizedBox(width: 16),

                Flexible(child: campoIcono(Icons.shield_sharp, Colors.grey, TextEditingController(text: personaje.claseArmadura.toString(),), readOnly: true, size: 80)),  
               
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Nivel", TextEditingController(text: personaje.nivel == null ?  "": personaje.nivel.toString() ), colorBasico, readOnly: true)),
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Experiencia", TextEditingController(text: personaje.experiencia == null ?  "" : personaje.experiencia.toString()), colorBasico, readOnly: true)),
        
                SizedBox(width: 20),
              ],
            ),
        
            SizedBox(height: 30),
        
        
            ExpansionTile(
              childrenPadding: EdgeInsets.all(16),
              title: Text("Características Físicas:"),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  children: [
                
                    Expanded(child: campo("Edad", TextEditingController(text: personaje.edad == null ? "" :  personaje.edad.toString()), colorBasico, readOnly: true)),
                
                    SizedBox(width: 10),
                
                    Expanded(child: campo("Altura", TextEditingController(text: personaje.altura  == null ? "" : personaje.altura.toString()), colorBasico, readOnly: true)),
                
                    SizedBox(width: 10),
                
                    Expanded(child: campo("Pelo", TextEditingController(text: personaje.pelo ?? ""), colorBasico, readOnly: true)),
                
                    
                    //String? imagenUrl;
                  ],
                ),
        
                SizedBox(height: 10),
        
                Row(
                  
                  children: [
                    
                    Expanded(child: campo("Peso", TextEditingController(text: personaje.peso == null ? "" : personaje.peso.toString()), colorBasico, readOnly: true)),
        
                    SizedBox(width: 10),
        
                    Expanded(child: campo("Ojos", TextEditingController(text: personaje.ojos ?? ""), colorBasico, readOnly: true)),
        
                    SizedBox(width: 10),
        
                    Expanded(child: campo("Piel", TextEditingController(text: personaje.piel ?? ""), colorBasico, readOnly: true)),
        
                  ]
                ),
              ],
            ),        
        
           
        
            SizedBox(height: 20,),
        
        
            ExpansionTile(
              childrenPadding: EdgeInsets.all(16),
              title: Text("Personalidad: "),
              children: [


                Row(
                  children: [

                    Expanded(child: campo("Alineamiento", TextEditingController(text: personaje.alineamiento), colorBasico, readOnly: true )),

                    Expanded(child: campo("Transfondo", TextEditingController(text: personaje.trasfondo), colorBasico, readOnly: true )),
                    
                  ],
                ),

                SizedBox(height: 10),
        
                SizedBox(
                height: 200,
                 child: Row(
                  children: [
                    //Rasgos
        
                    Expanded(
                      flex: 1,
                      child: TextFormField(readOnly: true,expands: true, maxLines: null,

                        style: TextStyle(fontWeight: FontWeight.bold),
                        minLines: null,                      

                        controller: TextEditingController(text: personaje.rasgos ?? ""),       
                        textAlignVertical: TextAlignVertical.top,             
                      
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        label: Text("Rasgos"),
                        ),
                      ),
                    ),
        
                    SizedBox(width: 16),
        
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        readOnly: true,
                        expands: true,
                        maxLines: null,
                        minLines: null,     
                        style: const TextStyle(fontWeight: FontWeight.bold),      

                        controller: TextEditingController(text: personaje.ideales ?? ""),       
                        textAlignVertical: TextAlignVertical.top,             
                      
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("Ideales"),
                        ),
                      ),
                    ),
        
                    SizedBox(width: 16),
        
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        readOnly: true,
                        expands: true,
                        maxLines: null,
                        minLines: null,        
                        style:  TextStyle(fontWeight: FontWeight.bold),  

                        controller: TextEditingController(text: personaje.vinculos ?? ""),       
                        textAlignVertical: TextAlignVertical.top,             
                      
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("vinculos"),
                        ),
                      ),
                    ),
        
                    SizedBox(width: 16),
        
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        readOnly: true,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        expands: true,
                        maxLines: null,
                        minLines: null,   

                        controller: TextEditingController(text: personaje.defectos ?? ""),       
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
               ),

               SizedBox(height: 15),


               SizedBox(
                width: double.infinity, // todo lo ancho que pueda
                height: 200,
                 child: TextFormField(expands: true, maxLines: null, minLines: null, 

                  style: TextStyle(fontWeight: FontWeight.bold),                     
                  controller: TextEditingController(text: personaje.historia),       
                  textAlignVertical: TextAlignVertical.top,             
                 
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colorBasico,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:  BorderSide(color: Color(0xFF6C63FF), width: 2),
                      ),

                    label: Text("Historia"),
                   ),
                 ),
               ),

               
                
              ],
            ),
            SizedBox(height: 30),

            //Salvacion + Iniciativa + Velocidad +  Bonificador Comp

            Divider(color: Colors.blue, thickness: 6),

            Text("Salvacion + Extras", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
      
            Divider(color: Colors.blue, thickness: 6),

            SizedBox(height: 20),

            Text("Tu bono de competencia actual: +${personaje.bonusCompetencia}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),      

            SizedBox(height: 20,),
            

            Row(
              children: [

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      campo("Iniciativa", TextEditingController(text: "+${personaje.iniciativa.toString()}"), colorBasico, readOnly: true),

                      SizedBox(height: 10),
                  
                      Image.asset('assets/Yo/iniciativa.png', width: 80, height: 85),
                      
                    ],
                  ),
                ),

                SizedBox(width: 10,),

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      campo("Velocidad", TextEditingController(text: personaje.velocidad.toString()), colorBasico, readOnly: true),

                      SizedBox(height: 10),
                  
                      Image.asset('assets/Yo/velocidad.png', width: 90, height: 90),
                      
                    ],
                  ),
                ),                          

              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [

                Flexible(
                  child: Column(
                    children: [
                      campoHabilidad("FUE", personaje),
                      campoHabilidad("DES", personaje),
                      campoHabilidad("CON", personaje),
                    ],
                  ),
                ),

                SizedBox(width: 15),

                Flexible(
                  child: Column(
                    children: [
                      campoHabilidad("INT", personaje),
                      campoHabilidad("SAB", personaje),
                      campoHabilidad("CAR", personaje),
                    ],
              ),
            ),

             ],
            ),           


            SizedBox(height: 30),

            //Stats main

            Divider(color: Colors.red, thickness: 6),

            Text("Estadísticas", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
      
            Divider(color: Colors.red, thickness: 6),

            SizedBox(height: 30),

            Row(
              children: [

                Expanded(child: campoStatSimple("Fuerza",       personaje.fuerza)),
                Expanded(child: campoStatSimple("Destreza",     personaje.destreza)),
                
              ],
            ),

            Row(
              children: [

                Expanded(child: campoStatSimple("Inteligencia", personaje.inteligencia)),
                Expanded(child: campoStatSimple("Sabiduría",    personaje.sabiduria)),
                

              ],
            ),

            Row(
              children: [
                Expanded(child: campoStatSimple("Constitución", personaje.constitucion)),
                Expanded(child: campoStatSimple("Carisma",      personaje.carisma)),

              ],
            ),

            SizedBox(height: 30),

            //stats secu

            ExpansionTile(
              title: Text("Stats Secundarias"),
              childrenPadding: EdgeInsets.all(16),

              children: [

                Row(

                  children: [

                    Expanded(
                      child: Column(
                        children: 
                        [
                          campoHabilidad('acrobacias', personaje),
                          campoHabilidad('atletismo', personaje),
                          campoHabilidad('C.arcano',  personaje),
                      
                          campoHabilidad('engaño', personaje),
                          campoHabilidad('historia', personaje),
                          campoHabilidad('interpretacion', personaje),
                      
                          campoHabilidad('intimidacion', personaje),
                          campoHabilidad('investigacion', personaje),
                          campoHabilidad('juegoDeManos',  personaje),
                      
                        ],
                      
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: 
                        [
                      
                          campoHabilidad('medicina', personaje),
                          campoHabilidad('naturaleza',  personaje),
                          campoHabilidad('percepcion', personaje),
                      
                          campoHabilidad('perspicacia', personaje),
                          campoHabilidad('persuasion',  personaje),
                          campoHabilidad('religion', personaje),
                      
                          campoHabilidad('sigilo', personaje),
                          campoHabilidad('supervivencia', personaje),
                          campoHabilidad('tratoAnimales',  personaje),
                      
                        ],
                      
                      ),
                    )
                  ],                
                ),
              ],            
            ),    
        
        
        
          ],
        ),
      ),
    );
  }
}