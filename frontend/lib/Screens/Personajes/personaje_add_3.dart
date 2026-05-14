

import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/personaje.dart';

class PersonajeAdd3 extends StatefulWidget {
  final Personaje personaje;
  const PersonajeAdd3({super.key, required this.personaje});

  @override
  State<PersonajeAdd3> createState() => _PersonajeAdd3State();
}

class _PersonajeAdd3State extends State<PersonajeAdd3> {
  
  Color colorBasico = Colors.grey.shade100;

  
 

  int bonusCompetencia = 0;  

   
  @override
  void initState() {
   
    super.initState();    
    
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        backgroundColor: AppConfig.colorAppBar,
        title: Text("Crear/Editar Personaje 3"),
        actions: [
          TextButton(
            onPressed: () {
            guardarCambios();
          }, 
          child: Text("Continuar"), 
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
        
          children: [

            Divider(color: Colors.blue, thickness: 6),
        
            Text("Habilidades Secundarias, Tiradas de Salvación y Bono Competencia", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),            
              
            Divider(color: Colors.blue, thickness: 6),
            
            SizedBox(height: 20,),
        
            Text("Las habilidades secundarias se calculan a partir de tus stats base. Según tu clase, algunas tendrán el bono de competencia sumado, lo que las hace más efectivas en combate y exploración.",
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            
            SizedBox(height: 10,),

            

            Text("El bono de competencia es un número que se suma a las tiradas en las que tu clase tiene entrenamiento. Empieza en +2 y sube cada 4 niveles hasta +6 al nivel 17.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        
            SizedBox(height: 20,), 

            Text("Tu bono de competencia actual: +${widget.personaje.bonusCompetencia}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),      

            SizedBox(height: 10,),
            
            Text("Las tiradas de salvación son tiradas que haces cuando algo malo te puede pasar y tienes que intentar resistirlo. Por ejemplo, si un mago te lanza un hechizo de fuego, puedes hacer una tirada de salvación de Destreza para esquivarlo a medias",
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

            SizedBox(height: 20,), 

            Divider(color: Colors.red, thickness: 6),


            Text("Habilidades Secundarias", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),            
              
            Divider(color: Colors.red, thickness: 6),

            SizedBox(height: 20,),  

            Text("Iniciativa: Determina el orden de actuación en combate. Se calcula tirando 1d20 y sumando el modificador de Destreza del personaje.",
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), 

            Text("Velocidad: Distancia máxima que puede recorrer un personaje en su turno. Es un valor fijo según la raza: humanos y elfos 30 pies (9 m), enanos y medianos 25 pies (7.5 m)." ,
             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), 

            SizedBox(height: 10,), 

            Row(
              children: [

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      campo("Iniciativa", TextEditingController(text: widget.personaje.iniciativa.toString()), colorBasico, readOnly: true),

                      SizedBox(height: 10),
                  
                      Image.asset('assets/yo/iniciativa.png', width: 80, height: 85),
                      
                    ],
                  ),
                ),

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      campo("Velocidad", TextEditingController(text: widget.personaje.velocidad.toString()), colorBasico, readOnly: true),

                      SizedBox(height: 10),
                  
                      Image.asset('assets/yo/velocidad.png', width: 100, height: 100),
                      
                    ],
                  ),
                ),                              

              ],
            ),

            SizedBox(height: 20,),     
                   
        
            Row(
              children: [
            
                Expanded(
                  child: Column(
                            
                    children: [
                      
                      campoHabilidad('acrobacias', widget.personaje),
                      campoHabilidad('atletismo', widget.personaje),
                      campoHabilidad('C.arcano', widget.personaje),
                      campoHabilidad('engano', widget.personaje),
                      campoHabilidad('historia', widget.personaje),
                      campoHabilidad('interpretacion', widget.personaje),
                      campoHabilidad('intimidacion', widget.personaje),
                      campoHabilidad('investigacion', widget.personaje),
                      campoHabilidad('juegoDeManos', widget.personaje),
                       
                    ],
                  ),
                ),
                     
                SizedBox(width: 20),
                
                Expanded(
                  child: Column(
                    children: [
                      
                      campoHabilidad('medicina', widget.personaje),
                      campoHabilidad('naturaleza', widget.personaje),
                      campoHabilidad('percepcion', widget.personaje),
                      campoHabilidad('perspicacia', widget.personaje),
                      campoHabilidad('persuasion', widget.personaje),
                      campoHabilidad('religion', widget.personaje),
                      campoHabilidad('sigilo', widget.personaje),
                      campoHabilidad('supervivencia', widget.personaje),
                      campoHabilidad('tratoAnimales', widget.personaje),

                    ],
                    ),
                ),
            
              ],
            ),   

            SizedBox(height: 20),

            
            Divider(color: Colors.green, thickness: 6),
              

            Text("Tiradas de Salvación", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),            
              
            Divider(color: Colors.green, thickness: 6),     

            SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: Column(
                    children: [
                  
                      campoHabilidad("FUE", widget.personaje),
                      campoHabilidad("DES", widget.personaje),
                      campoHabilidad("CON", widget.personaje),
                      
                    ],
                  ),
                ), 

                Expanded(
                  child: Column(
                    children: [
                  
                      campoHabilidad("INT", widget.personaje),
                      campoHabilidad("SAB", widget.personaje),
                      campoHabilidad("CAR", widget.personaje),
                      
                    ],
                  ),
                )

                
              ],
            )


        
          ],
        ),
      ),

    );
  }



  void guardarCambios() async {       


    widget.personaje.habilidades = {

      'acrobacias': widget.personaje.modHabilidad('acrobacias'),
      'atletismo': widget.personaje.modHabilidad('atletismo'),
      'C.arcano': widget.personaje.modHabilidad('C.arcano'),
      'engano': widget.personaje.modHabilidad('engano'),
      'historia': widget.personaje.modHabilidad('historia'),
      'interpretacion': widget.personaje.modHabilidad('interpretacion'),
      'intimidacion': widget.personaje.modHabilidad('intimidacion'),
      'investigacion': widget.personaje.modHabilidad('investigacion'),
      'juegoDeManos': widget.personaje.modHabilidad('juegoDeManos'),
      'medicina': widget.personaje.modHabilidad('medicina'),
      'naturaleza': widget.personaje.modHabilidad('naturaleza'),
      'percepcion': widget.personaje.modHabilidad('percepcion'),
      'perspicacia': widget.personaje.modHabilidad('perspicacia'),
      'persuasion': widget.personaje.modHabilidad('persuasion'),
      'religion': widget.personaje.modHabilidad('religion'),
      'sigilo': widget.personaje.modHabilidad('sigilo'),
      'supervivencia': widget.personaje.modHabilidad('supervivencia'),
      'tratoAnimales': widget.personaje.modHabilidad('tratoAnimales'),

    };

    Navigator.of(context).pop(widget.personaje);

    
  }   

    
}