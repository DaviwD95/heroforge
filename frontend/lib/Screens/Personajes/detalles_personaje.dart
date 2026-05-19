import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Components/formulario_helpers.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class DetallesPersoonaje extends StatefulWidget {
  
  final Personaje personaje;
  final bool modificable;
  const DetallesPersoonaje({super.key, required this.personaje, required this.modificable});

  @override
  State<DetallesPersoonaje> createState() => _DetallesPersoonajeState();
}

class _DetallesPersoonajeState extends State<DetallesPersoonaje> {

  File? _imagenFile;
  Uint8List? _imagenBytes;

  late PersonajeViewModel vm;

   @override
  void initState() {
    super.initState();  
    
    vm = Provider.of<PersonajeViewModel>(context, listen: false);
    
    }



  @override
  Widget build(BuildContext context) {

    

    Color colorBasico = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        title: Text("Detalles: ${widget.personaje.nombre}"),
        backgroundColor: colorSegunClase(widget.personaje),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
        
          children: [

            SizedBox(height: 10),
            //Basico
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [
        
                Expanded(
                  child: Column(
                    children: [
                  
                      
                          
                      campo("Nombre Personaje", TextEditingController(text: widget.personaje.nombre), colorBasico, readOnly: true),
                          
                      SizedBox(height: 20),
                          
                      campo("Nombre del jugador", TextEditingController(text: widget.personaje.nombreJugador), colorBasico, readOnly: true),
                          
                      
                    ],
                  ),
                ),

                 SizedBox(width: 30),
                          


                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // 40% del ancho de pantal
                  height: 280,
                  child: InkWell(
                    child: Container(                            
                  
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorSegunClase(widget.personaje) ?? Colors.greenAccent, width: 3),
                      ),
                  
                      child: ClipRRect(
                        //ClipOval para ciruclos, clipReact para rectangulos
                        borderRadius: BorderRadius.circular(12),
                        child: _buildImagePersonaje(widget.personaje),
                      ),
                    ),
                  
                    onTap: () {
                      if(widget.modificable== true)
                      {
                        _seleccionarImagen(widget.personaje);
                      }                    
                      
                    },
                  ),
                ),

              ],
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [

                Flexible(
                  child: Column(
                    children: [
                  
                      campo("Clase", TextEditingController(text: widget.personaje.claseBase), colorBasico, readOnly: true),
                  
                      SizedBox(height: 10),
                  
                      Image.asset(imagenSegunClase(widget.personaje.claseBase), width: 80, height: 85),
                    ],
                  ),
                ),

                SizedBox(width: 16),

                Flexible(
                  child: Column(
                    
                    children: [
                  
                      campo("Raza", TextEditingController(text: widget.personaje.raza), colorBasico, readOnly: true),
                  
                      SizedBox(height: 10),
                  
                      Image.asset(imagenSegunRaza(widget.personaje.raza), width: 80, height: 85),
                    ],
                  ),
                ),

                SizedBox(width: 16),
                
                Flexible(child: campoIcono(Icons.favorite, Colors.red, TextEditingController(text: widget.personaje.puntosGolpeMax.toString()), size: 80, readOnly: true)),

                SizedBox(width: 16),

                Flexible(child: campoIcono(Icons.shield_sharp, Colors.grey, TextEditingController(text: widget.personaje.claseArmadura.toString(),), readOnly: true, size: 80)),  
               
              ],
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
        
              children: [
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Nivel", TextEditingController(text: widget.personaje.nivel == null ?  "": widget.personaje.nivel.toString() ), colorBasico, readOnly: true)),
        
                SizedBox(width: 20),
        
                Expanded(child: campo("Experiencia", TextEditingController(text: widget.personaje.experiencia == null ?  "" : widget.personaje.experiencia.toString()), colorBasico, readOnly: true)),
        
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
                
                    Expanded(child: campo("Edad", TextEditingController(text: widget.personaje.edad == null ? "" :  widget.personaje.edad.toString()), colorBasico, readOnly: true)),
                
                    SizedBox(width: 10),
                
                    Expanded(child: campo("Altura", TextEditingController(text: widget.personaje.altura  == null ? "" : widget.personaje.altura.toString()), colorBasico, readOnly: true)),
                
                    SizedBox(width: 10),
                
                    Expanded(child: campo("Pelo", TextEditingController(text: widget.personaje.pelo ?? ""), colorBasico, readOnly: true)),
                
                    
                    //String? imagenUrl;
                  ],
                ),
        
                SizedBox(height: 10),
        
                Row(
                  
                  children: [
                    
                    Expanded(child: campo("Peso", TextEditingController(text: widget.personaje.peso == null ? "" : widget.personaje.peso.toString()), colorBasico, readOnly: true)),
        
                    SizedBox(width: 10),
        
                    Expanded(child: campo("Ojos", TextEditingController(text: widget.personaje.ojos ?? ""), colorBasico, readOnly: true)),
        
                    SizedBox(width: 10),
        
                    Expanded(child: campo("Piel", TextEditingController(text: widget.personaje.piel ?? ""), colorBasico, readOnly: true)),
        
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

                    Expanded(child: campo("Alineamiento", TextEditingController(text: widget.personaje.alineamiento), colorBasico, readOnly: true )),

                    Expanded(child: campo("Transfondo", TextEditingController(text: widget.personaje.trasfondo), colorBasico, readOnly: true )),
                    
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

                        controller: TextEditingController(text: widget.personaje.rasgos ?? ""),       
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

                        controller: TextEditingController(text: widget.personaje.ideales ?? ""),       
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

                        controller: TextEditingController(text: widget.personaje.vinculos ?? ""),       
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

                        controller: TextEditingController(text: widget.personaje.defectos ?? ""),       
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
                  controller: TextEditingController(text: widget.personaje.historia),       
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

            Text("Tu bono de competencia actual: +${widget.personaje.bonusCompetencia}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),      

            SizedBox(height: 20,),
            

            Row(
              children: [

                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      campo("Iniciativa", TextEditingController(text: "+${widget.personaje.iniciativa.toString()}"), colorBasico, readOnly: true),

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

                      campo("Velocidad", TextEditingController(text: widget.personaje.velocidad.toString()), colorBasico, readOnly: true),

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
                      campoHabilidad("FUE", widget.personaje),
                      campoHabilidad("DES", widget.personaje),
                      campoHabilidad("CON", widget.personaje),
                    ],
                  ),
                ),

                SizedBox(width: 15),

                Flexible(
                  child: Column(
                    children: [
                      campoHabilidad("INT", widget.personaje),
                      campoHabilidad("SAB", widget.personaje),
                      campoHabilidad("CAR", widget.personaje),
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

                Expanded(child: campoStatSimple("Fuerza",       widget.personaje.fuerza)),
                Expanded(child: campoStatSimple("Destreza",     widget.personaje.destreza)),
                
              ],
            ),

            Row(
              children: [

                Expanded(child: campoStatSimple("Inteligencia", widget.personaje.inteligencia)),
                Expanded(child: campoStatSimple("Sabiduría",    widget.personaje.sabiduria)),
                

              ],
            ),

            Row(
              children: [
                Expanded(child: campoStatSimple("Constitución", widget.personaje.constitucion)),
                Expanded(child: campoStatSimple("Carisma",      widget.personaje.carisma)),

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
                          campoHabilidad('acrobacias', widget.personaje),
                          campoHabilidad('atletismo', widget.personaje),
                          campoHabilidad('C.arcano',  widget.personaje),
                      
                          campoHabilidad('engaño', widget.personaje),
                          campoHabilidad('historia', widget.personaje),
                          campoHabilidad('interpretacion', widget.personaje),
                      
                          campoHabilidad('intimidacion', widget.personaje),
                          campoHabilidad('investigacion', widget.personaje),
                          campoHabilidad('juegoDeManos',  widget.personaje),
                      
                        ],
                      
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: 
                        [
                      
                          campoHabilidad('medicina', widget.personaje),
                          campoHabilidad('naturaleza',  widget.personaje),
                          campoHabilidad('percepcion', widget.personaje),
                      
                          campoHabilidad('perspicacia', widget.personaje),
                          campoHabilidad('persuasion',  widget.personaje),
                          campoHabilidad('religion', widget.personaje),
                      
                          campoHabilidad('sigilo', widget.personaje),
                          campoHabilidad('supervivencia', widget.personaje),
                          campoHabilidad('tratoAnimales',  widget.personaje),
                      
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

  Widget _buildImagePersonaje(Personaje personaje) {
    
    if (_imagenBytes != null) {

      return Image.memory(_imagenBytes!, fit: BoxFit.contain);

    } else if (_imagenFile != null) {

      return Image.file(_imagenFile!, fit: BoxFit.contain);

    } else if (personaje.imagenUrl != null) { 

      //Se pone para que flutter piense que es difernte y la recargue 
      return Image.network("${personaje.imagenUrl!}?t=${DateTime.now().millisecondsSinceEpoch}", fit: BoxFit.contain);

     } else {
      return Icon(Icons.person, size: 50, color: Colors.grey);
    }
  }

  Future<void> _seleccionarImagen(Personaje personaje) async 
  {

   final picker = ImagePicker();

   //Seleccionar la imagen de la galeria
   final XFile? image = await picker.pickImage(
     source: ImageSource.gallery,
     imageQuality: 70,
     maxWidth: 300,
     maxHeight: 300,
   );

   //Si no se selecciona nada pues no devolvemos nada
   if (image == null) return;
  
   if (kIsWeb) {
     
     final bytes = await image.readAsBytes();
     
     setState(() {
      _imagenBytes = bytes;
      _imagenFile = null;
     });

     bool? cambio = await vm.cambiarFotoPersonaje(null, _imagenBytes, context, personaje);

     if(cambio == true)
     {
       ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado la foto de perfil con exito!")),);
     }else
     {
       ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal al cambiar la foto de perfil")),);
     } 

   }else 
   {

     setState(() {

       _imagenFile = File(image.path);
      _imagenBytes = null;
     });

     bool? cambio = await vm.cambiarFotoPersonaje(_imagenFile, null, context, personaje);

     if(cambio == true)
     {
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado la foto de perfil con exito!")),);
     }else
     {
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal al cambiar la foto de perfil")),);
     }
    
    }
  }
}