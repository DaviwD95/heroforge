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
                
                campoIcono(Icons.favorite, Colors.red, TextEditingController(text: personaje.puntosGolpeMax.toString()), size: 80),

                SizedBox(width: 16),

                campoIcono(Icons.shield_sharp, Colors.grey, TextEditingController(text: personaje.claseArmadura.toString()), size: 80),  
               
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

            //Stats main

            Row(
              children: [

                Expanded(child: campoStatSimple("Fuerza",       personaje.fuerza)),
                Expanded(child: campoStatSimple("Destreza",     personaje.destreza)),
                Expanded(child: campoStatSimple("Constitución", personaje.constitucion)),

              ],
            ),

            Row(
              children: [

                Expanded(child: campoStatSimple("Inteligencia", personaje.inteligencia)),
                Expanded(child: campoStatSimple("Sabiduría",    personaje.sabiduria)),
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
                          campoHabilidadSimple('acrobacias',    personaje.habilidades['acrobacias']    ?? 0),
                          campoHabilidadSimple('atletismo',     personaje.habilidades['atletismo']     ?? 0),
                          campoHabilidadSimple('C.arcano',      personaje.habilidades['C.arcano']      ?? 0),
                      
                          campoHabilidadSimple('engano',        personaje.habilidades['engano']        ?? 0),
                          campoHabilidadSimple('historia',      personaje.habilidades['historia']      ?? 0),
                          campoHabilidadSimple('interpretacion',personaje.habilidades['interpretacion']?? 0),
                      
                          campoHabilidadSimple('intimidacion',  personaje.habilidades['intimidacion']  ?? 0),
                          campoHabilidadSimple('investigacion', personaje.habilidades['investigacion'] ?? 0),
                          campoHabilidadSimple('juegoDeManos',  personaje.habilidades['juegoDeManos']  ?? 0),
                      
                        ],
                      
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: 
                        [
                      
                          campoHabilidadSimple('medicina',      personaje.habilidades['medicina']      ?? 0),
                          campoHabilidadSimple('naturaleza',    personaje.habilidades['naturaleza']    ?? 0),
                          campoHabilidadSimple('percepcion',    personaje.habilidades['percepcion']    ?? 0),
                      
                          campoHabilidadSimple('perspicacia',   personaje.habilidades['perspicacia']   ?? 0),
                          campoHabilidadSimple('persuasion',    personaje.habilidades['persuasion']    ?? 0),
                          campoHabilidadSimple('religion',      personaje.habilidades['religion']      ?? 0),
                      
                          campoHabilidadSimple('sigilo',        personaje.habilidades['sigilo']        ?? 0),
                          campoHabilidadSimple('supervivencia', personaje.habilidades['supervivencia'] ?? 0),
                          campoHabilidadSimple('tratoAnimales', personaje.habilidades['tratoAnimales'] ?? 0),
                      
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