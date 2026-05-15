import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Screens/Personajes/detalles_personaje.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:provider/provider.dart';

class Personajetile extends StatefulWidget {
  
  final bool modificable;
  final Personaje personaje;
  const Personajetile({super.key, required this.personaje, required this.modificable});

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

          onTap: () {

             Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetallesPersoonaje(personaje: widget.personaje),),);
    
            


            
          },
          
          onLongPress: widget.modificable ? () async {

            showDialog(context: context, builder: (context)
            {
              return Dialog(               

   
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                child: Padding(

                  padding:  EdgeInsets.all(20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        
                        Container(
                          alignment: Alignment.centerRight,
                          width:  double.infinity, 
                          height: 30,
                          color: colorSegunClase(widget.personaje),

                          child: Padding(

                            padding: EdgeInsets.symmetric(horizontal: 42),
                            child: Center(child: Text("Nombre: ${widget.personaje.nombre} Nivel: ${widget.personaje.nivel}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),),
                       ),

                       SizedBox(height: 25,),

                       Wrap(
                          spacing: 8,
                          runSpacing: 8,

                          children: [

                            botonDialog(
                              Icons.edit,
                              "Editar",
                              Colors.amberAccent,() async {

                                bool? condicion = await vm.editPersonaje(context,widget.personaje,);

                                if (condicion == true) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Personaje editado con exito",),),);
                                  Navigator.pop(context);

                                } else if (condicion == false) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error, algo salio mal en la  edicion",),),);
                                  
                                  Navigator.pop(context);
                                }
                              },
                            ),

                            botonDialog(
                              Icons.remove,
                              "Eliminar",
                              Colors.red, () async {

                                bool? condicion = await vm.removePersonaje(context, widget.personaje,);

                                if (condicion == true) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Personaje eliminado con exito",),),);
                                  Navigator.pop(context);

                                } else if (condicion == false) {
                                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text( "Error, algo salio mal en la eliminacion",),),);
                                  Navigator.pop(context);

                                }
                              },
                            ),

                            botonDialog(
                              Icons.upload,
                              "Publicar",
                              Colors.purple,() async {

                                bool? condicion = await vm.publicarPersonaje(context,widget.personaje);

                                if (condicion == true) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Personaje publicado con exito",),),);
                                  Navigator.pop(context);

                                } else if (condicion == false) {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error, algo salio mal en la publicacion, puede que ya este publicado",),),);
                                  Navigator.pop(context);
                                }
                              },
                            ),

                            botonDialog(
                              Icons.arrow_back_rounded,
                              "Cancelar",
                              Colors.grey,
                              () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),

                  
                ],
              ),),

                

              );

            });
            
          } : null,
          
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

                                //Flexible hace que que no entra el texto y se desbordaria, se hace mas pequeño y no se ve feo
          
                                Flexible(
                                    child: Text(
                                    overflow: TextOverflow.ellipsis, //se pone ... si no entra
                                    widget.personaje.nombre ?? "", 
                                    style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                                  ),
          
                                SizedBox(width: 4),
          
                                Text("-"),
          
                                SizedBox(width: 4),

                                Flexible(
                                    child: Text(
                                    overflow: TextOverflow.ellipsis, //se pone ... si no entra
                                    widget.personaje.raza ?? "", 
                                    style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                                  ),
          
                                
          
                              ],
                            ),                     
                            
                            SizedBox(height: 5),                   
                            
                            Text("${widget.personaje.clase ?? ""} -  ${widget.personaje.alineamiento ?? ""}",  style:  TextStyle(fontSize: 15)),
          
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

                Padding(                  
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Align( //Align ayuda a ponerlo  a la izquierda 

                    alignment: Alignment.centerLeft,
                    child: Text("Nombre Jugador: ${widget.personaje.nombreJugador ?? "Desconocido"}",  style: TextStyle(fontSize: 11, color: Colors.grey),)
                  ),
                ),
              ],
            ),
            
          ),
        ),
      ),
    );
  }


  

  Widget botonDialog(IconData icon, String label,  Color? color, VoidCallback onTap) {
    
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    
      child: TextButton(
        onPressed: onTap, 
        child: Row(
          children: [

            Icon(icon, color: Colors.white),
            SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),

          ],
        ))
    );
 }
}