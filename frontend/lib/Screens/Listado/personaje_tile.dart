import 'package:flutter/material.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:provider/provider.dart';

class Personajetile extends StatefulWidget {

  final Personaje personaje;
  const Personajetile({super.key, required this.personaje});

  @override
  State<Personajetile> createState() => _PersonajetileState();
}

class _PersonajetileState extends State<Personajetile> {

  late PersonajeViewModel vm;


  @override
  void initState() {   
    super.initState();

    vm = Provider.of<PersonajeViewModel>(context, listen: false);

  }


  @override
  Widget build(BuildContext context) {

    return  Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        //Con el on tap puedo hacer bien el  on tap 

        child: InkWell(
          onTap: () async {

            showDialog(context: context, builder: (context)
            {
              return AlertDialog(

                title: Text("Personaje ${widget.personaje.nombre}"),

                actions: [

                  //Editar

                  TextButton(onPressed: () async {

                   

                    bool? condicion =  await vm.editPersonaje(context, widget.personaje);

                    if (condicion == true) {

                     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Personaje editado con exito")),);
                     Navigator.pop(context);

                    } else if (condicion == false) 
                    {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error, algo salio mal en la  edicion"),),);
                     Navigator.pop(context);
                    }

                  }, child: Text("Editar")),

                  //Elimina


                  TextButton(onPressed: () async  {
   

                    bool? condicion =  await vm.removePersonaje(context, widget.personaje);

                    if (condicion == true) {

                     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Personaje eliminado con exito")),);
                     Navigator.pop(context);

                    } else if (condicion == false) 
                    {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error, algo salio mal en la eliminacion"),),);
                     Navigator.pop(context);
                    }


                  }, child: Text("Eliminar"))
                ],

              );

            });
            
          },
          child: Card(
          
            elevation: 4,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          
            child: Column(
              children: [
            
                Container(
                  alignment: Alignment.centerRight,
                  width:  double.infinity,
                  height: 30,
                  color: colorSegunClase(widget.personaje),
          
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42),
                    child: Text("Nivel: ${widget.personaje.nivel}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  //En un principio queria LisTile, pero el trailing me daba complicaciones con la imagen 
          
                  child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          
                      Expanded(
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                         
                        
                           children: [
          
                            Row(
                              children: [
          
                                Text(widget.personaje.nombre ?? "", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          
                                SizedBox(width: 4),
          
                                Text("-"),
          
                                SizedBox(width: 4),
          
                                Text(widget.personaje.raza ?? "", style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),                      
          
                              ],
                            ),                     
                            
                            SizedBox(height: 5),                   
                            
                            Text("${widget.personaje.clase ?? ""} -  ${widget.personaje.alineamiento ?? ""}",  style:  TextStyle(fontSize: 16)),
          
                             SizedBox(height: 7), 
          
                           // Text("Fuerza: ${widget.personaje.fuerza} Destreza "),
                            Wrap(
                              spacing: 8,
                              children:
                             [
                               Text("FUE: ${widget.personaje.fuerza}" ,  style:  TextStyle(fontSize: 12)),
                               Text("DES: ${widget.personaje.destreza}",  style:  TextStyle(fontSize: 12)),
                               Text("CON: ${widget.personaje.constitucion}",  style:  TextStyle(fontSize: 12)),
                               Text("INT: ${widget.personaje.inteligencia}",  style:  TextStyle(fontSize: 12)),
                               Text("SAB: ${widget.personaje.sabiduria}",  style:  TextStyle(fontSize: 12)),
                               Text("CAR: ${widget.personaje.carisma}",  style:  TextStyle(fontSize: 12)),
                            ],
                            ),
                        
                        
                           ],
                        ),
                      ),
          
                     // SizedBox(width: 100),
          
                      Image.asset(imagenSegunClase(widget.personaje.claseBase), width: 100, height: 100, fit: BoxFit.contain,),
                    ],                 
                    
                    
                    )
          
                   
                  ,
                ),
              ],
            ),
            
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