import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:math';




class Dados extends StatefulWidget {
  const Dados({super.key});

  @override
  State<Dados> createState() => _DadosState();
}

class _DadosState extends State<Dados> {

    bool _animando = false;

    Timer? _timer;

    int modificador = 0;
    int cantidad = 1; 

    int? resultadoActual;
    String? tiradaModificadorAparte = "";
    List<String> historial = [];



  @override
  Widget build(BuildContext context) {

   

    //Esto hace que se adapten el tamaño de los dados

    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = (screenWidth / 5).clamp(40.0, 90.0);//Clamp es el para poner minimo y maximo 


    return Column(

      children: [

        Container(
          color: Color(0xFFD4A574),// Colors.grey[300],

          child: Center(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center, 
            
              children: [
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
            
                  children: 
                  [
            
                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(4);


                        }, icon: Image.asset('assets/dados/d4.png',  
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                        Text("d4")
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(6);


                        }, icon: Image.asset('assets/dados/d6.png', 
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                         Text("d6")
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(8);


                        }, icon: Image.asset('assets/dados/d8.png', 
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                         Text("d8")
                      ],
                    ),      

                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(10);


                        }, icon: Image.asset('assets/dados/d10.png', 
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                         Text("d10")
                      ],
                    )              

                  ],
            
                ),

                SizedBox(height: 5),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
            
                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(12);


                        }, icon: Image.asset('assets/dados/d12.png',  
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                         Text("d12")
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(20);


                        }, icon: Image.asset('assets/dados/d20.png', 
                        width: iconSize, height: iconSize, fit: BoxFit.contain,)),

                         Text("d20")
                      ],
                    ),

                    Column(
                      children: [
                        IconButton(onPressed: () {
                          tirarDado(100);

                          
                        }, icon: Image.asset('assets/dados/d100.png', 
                        width: iconSize+10, height: iconSize+10, fit: BoxFit.contain,)),

                         Text("d100")
                      ],
                    ),      

                     
                    
                  ],
                )
              ],
            ),
          ),
        ),

        //----------Resultado---------
        SizedBox(height: 30),

        
        Container(         
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(16),
        
          decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple),),
            
            child: Column(
              children: [
                Text("${resultadoActual ?? 0}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
        
                SizedBox(height: 5,),
        
                Text("$tiradaModificadorAparte",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepPurple),)
              ],
            ),
            ),

         SizedBox(height: 30),

        //--------Historial-------

         Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[400]!),
          ),

          child: Column(
            children: [

              Text("Historial"),
              Text(
                historial.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        SizedBox(height: 30),


        //------Cantidad/Modificador 

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Column(
              children: [
            
                //------------Cantidad-------------
                Text("Numero de Dados"),
            
                SizedBox(height: 5),
            
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                
                  children: [
                    //Menos
                
                    IconButton(
                
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),       
                 
                      onPressed: () => setState(() { if (cantidad > 1) cantidad--; }),
                
                      icon: Icon(Icons.remove)
                      ),
                
                    //Numero
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                
                      decoration: BoxDecoration(
                
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[400]!),
                
                        ),
                
                    child: Text(cantidad.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                    
                    ),
                    //Mas 
                    IconButton(
                
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),       
                      
                      onPressed: () => setState(() {  cantidad++; }),
                
                      icon: Icon(Icons.add)
                      ),
                    
                
                
                  ],
                ),
              ],
            ),

            SizedBox(width: 5),

            //------------Modificador-------------
            Column(
              children: 
              [
                Text("Modificador"),

                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    //Menos
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      onPressed: () => setState(() {
                        modificador--;
                      }),

                      icon: Icon(Icons.remove),
                    ),

                    //Numero
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[400]!),
                      ),

                      child: Text(
                        modificador.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    //Mas
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      onPressed: () => setState(() {
                        modificador++;
                      }),

                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
          ],
        ),




          ],
        ),
      ],
    );
  }

  void tirarDado(int caras) {
    //Primero calculamos el resultado real
    final resultadoFinal = sumarDados(caras);
    int ticks = 0;

    //Cancelamps los ticks por si ya habia uno empezad
    _timer?.cancel();

    //Hacemos que en pantalla se calcule varias veces el resultado variando
    _timer = Timer.periodic(Duration(milliseconds: 80), (timer) {
      setState(() {
        resultadoActual = sumarDados(caras);
      });

      ticks++;

      if (ticks >= 15) {
        // después de 15 ticks cae el resultado final
        timer.cancel();

        setState(() {
          resultadoActual = resultadoFinal + modificador;
          tiradaModificadorAparte = "$resultadoFinal + $modificador";
          historial.insert(
            0,
            "${cantidad}d$caras + $modificador = $resultadoActual",
          );
          if (historial.length > 10) historial.removeLast();
        });
      }
    });
  }

  int sumarDados(int caras) {

    int suma = 0;
    for (int i = 0; i < cantidad; i++) {
      suma += Random().nextInt(caras) + 1;
    }
    return suma;

  }



 











 /**
  *  void tirarDado(int caras) {

   setState(() {

     final tirada = Random().nextInt(caras) + 1;
     

     resultadoActual = tirada + modificador;

     tiradaModificadorAparte = "$tirada + $modificador";

     historial.insert(0, "${cantidad}d$caras + $modificador = $resultadoActual");

     if (historial.length > 10) historial.removeLast(); // tiene de tope 10

     _animando = !_animando; 

  });
 }
  */
}