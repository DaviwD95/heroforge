

import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/models/personaje.dart';

class PersonajeAdd3 extends StatefulWidget {
  final Personaje personaje;
  const PersonajeAdd3({super.key, required this.personaje});

  @override
  State<PersonajeAdd3> createState() => _PersonajeAdd3State();
}

class _PersonajeAdd3State extends State<PersonajeAdd3> {

  
 

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
                   
        
            Row(
              children: [
            
                Expanded(
                  child: Column(
                            
                    children: [
                      
                      campoHabilidad('acrobacias'),
                      campoHabilidad('atletismo'),
                      campoHabilidad('C.arcano'),
                      campoHabilidad('engano'),
                      campoHabilidad('historia'),
                      campoHabilidad('interpretacion'),
                      campoHabilidad('intimidacion'),
                      campoHabilidad('investigacion'),
                      campoHabilidad('juegoDeManos'),
                       
                    ],
                  ),
                ),
                     
                SizedBox(width: 20),
                
                Expanded(
                  child: Column(
                    children: [
                      
                      campoHabilidad('medicina'),
                      campoHabilidad('naturaleza'),
                      campoHabilidad('percepcion'),
                      campoHabilidad('perspicacia'),
                      campoHabilidad('persuasion'),
                      campoHabilidad('religion'),
                      campoHabilidad('sigilo'),
                      campoHabilidad('supervivencia'),
                      campoHabilidad('tratoAnimales'),

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
                  
                      campoHabilidad("FUE"),
                      campoHabilidad("DES"),
                      campoHabilidad("CON"),
                      
                    ],
                  ),
                ), 

                Expanded(
                  child: Column(
                    children: [
                  
                      campoHabilidad("INT"),
                      campoHabilidad("SAB"),
                      campoHabilidad("CAR"),
                      
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

  Widget campoHabilidad(String nombre) {

    //Asi diferencio si es una stats normal o es salvacion 

    final esSalvacion = ['FUE', 'DES', 'CON', 'INT', 'SAB', 'CAR'].contains(nombre);

    final valor     = esSalvacion ? widget.personaje.modSalvacion(nombre) : widget.personaje.modHabilidad(nombre);
    final tieneComp = esSalvacion ? widget.personaje.tieneCompSalvacion(nombre) : widget.personaje.tieneCompHabilidad(nombre);


    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple),
      ),
      
      child: Row(
        children: [
          

          //Checkboxe si tiene bonus clase
          SizedBox(            
            width: 20,
            height: 20,
            child: Checkbox(
              value: tieneComp,
              onChanged: null, 
              activeColor: Colors.deepPurple,
            ),
          ),

    
          SizedBox(width: 5),
          
          Text("_${valor >= 0 ? '+' : ''}$valor _",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
          
          SizedBox(width: 5),

          Expanded(child: Text(nombre, style: TextStyle(fontSize: 11), textAlign: TextAlign.center)),

          SizedBox(width: 3),

          Text(esSalvacion ? "" : widget.personaje.statDeHabilidad(nombre), style: TextStyle(fontSize: 11), textAlign: TextAlign.center),


        ],
      )
    );
  }    
}