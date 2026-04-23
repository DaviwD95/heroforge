import 'package:flutter/material.dart';
import 'package:heroforge/models/Personaje.dart';

class Personajetile extends StatefulWidget {

  final Personaje personaje;
  const Personajetile({super.key, required this.personaje});

  @override
  State<Personajetile> createState() => _PersonajetileState();
}

class _PersonajetileState extends State<Personajetile> {


  @override
  Widget build(BuildContext context) {

    return  Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),

        child: Card(

          elevation: 4,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        
          child: Column(
            children: [
          
              Container(
                width:  double.infinity,
                height: 30,
                color: colorSegunClase(widget.personaje)
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),

                child: ListTile( 

                    minTileHeight: 150,
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                     
                
                  title: Row(children: [ //nombre clase raza nibel 
                
                    Text(widget.personaje.nombre ?? "") ,

                    Divider(),
                
                    Text(widget.personaje.raza ?? "")
                  ],),
                
                  subtitle: Text(widget.personaje.clase ?? ""),

                  trailing: UnconstrainedBox(

                   
                    child:  Image.asset(imagenSegunClase(widget.personaje.claseBase), width: 150, height: 150, fit: BoxFit.contain,),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Color? colorSegunClase(Personaje personaje)
  {

    if(personaje.claseBase == "Guerrero")
    {
      return Colors.red[400];

    }else if(personaje.claseBase == "Mago"){

      return Colors.blue;      

    }else if(personaje.clase == "Clerigo"){

      return Colors.amber[300];      
    }
    else if(personaje.claseBase == "Picaro"){

      return Colors.brown;      

    }else if(personaje.claseBase == "Artificiero"){

      return Colors.green;      
    }
  }

  String imagenSegunClase(String? clase) {
      
      const imagenes = {
        'Guerrero':    'assets/clases/guerrero.png',
        'Mago':        'assets/clases/mago.png',
        'Clerigo':     'assets/clases/clerigo.png',
        'Picaro':      'assets/clases/picaro.png',
        'Artificiero': 'assets/clases/artificiero.png',
        };
      return imagenes[clase] ?? 'assets/clases/default.png';
      }
}