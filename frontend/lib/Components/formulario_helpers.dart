 import 'package:flutter/material.dart';
import 'package:heroforge/models/personaje.dart';




//Validador para campos Duoble 

String? validarDouble(String? value, {bool obligatorio = false}) {

  if (obligatorio && (value == null || value.trim().isEmpty)) {
    return "Obligatorio";
  }

  final n = double.tryParse(value ?? '');

  if (value != null && value.isNotEmpty && n == null) {
    return "Solo números (0.0)";
  }
  return null;

}

//Validador de campo obligatorio


String? validarCampoObligatorio(String? value) {
  
  
  if (value == null || value.trim().isEmpty) {
    return "Este campo es obligatorio";
  }
  return null;
}

//Validador para numero obligatorio 


String? validarNumeroObligatorio(String? value, { bool obligatorio = false}) {
  

  if (obligatorio && (value == null || value.trim().isEmpty))
  {
    return "Obligatorio";
  }

  final n = int.tryParse(value ?? '');

  if (value != null && value.isNotEmpty && n == null)
  {
    return "Solo números";
  }
     
  return null; 
  
 
}

    


//Drop down 

Widget dropDown(String label, String? value, List<String> opciones, ValueChanged<String?> onChanged) {

  return SizedBox(

   // width: double.infinity, //ocupa todo el espacio del ancho disponible 
    child: DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
      decoration: InputDecoration(

        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      items: opciones.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    ),
  );
}

Widget campoNumero(String label, TextEditingController controller, Color colorFondo, {bool obligatorio = true}) {

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: TextStyle(fontWeight: FontWeight.bold),
    decoration: _inputDeco(label, colorFondo),

    validator: (value) => validarNumeroObligatorio(value, obligatorio: obligatorio)

  );
}

Color? colorSegunClase(Personaje personaje)
  {

    if(personaje.claseBase == "Guerrero")
    {
      return Colors.red[400];

    }else if(personaje.claseBase == "Mago"){

      return Colors.blue;      

    }else if(personaje.claseBase == "Clerigo"){

      return Colors.amber[300];      
    }
    else if(personaje.claseBase == "Picaro"){

      return Colors.brown;      

    }else if(personaje.claseBase == "Artificiero"){

      return Colors.green;      
    }
    return null;
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

  String imagenSegunRaza(String? raza) {
      
    const imagenes = {
        'Humano':    'assets/razas/humano.png',
        'Elfo':        'assets/razas/elfo.png',
        'Mediano':     'assets/razas/mediano.png',
        'Enano':      'assets/razas/enano.png',        
        };
    return imagenes[raza] ?? 'assets/clases/default.png';
  }


//Para poder hacer escribir en iconos, hacinedolo visualmente mas agradable

Widget campoIcono(IconData icono, Color colorIcono, TextEditingController? controller, {double size = 120, bool readOnly = false }) 
 {
  return Column(
    children: [
      Stack(
      
        alignment: Alignment.center,
        children: [
      
          Icon(icono, color: colorIcono, size: size),  // el corazon/escudo grande de fondo
      
          SizedBox(
            width: 40,
            child: TextFormField(
              readOnly: readOnly,
             // validator: validarNumeroObligatorio,
              controller: controller,
              textAlign: TextAlign.center,          
              keyboardType: TextInputType.number, 
              
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,  // sin borde, que no se vea el campo
                isDense: true, //Limita el padding vertical, haciendo que al escribir, no se salga del icono
              ),
            ),
          ),
        ],
      ),
  
    //El campo de error en lo iconos es de esta forma, ya que si no no se apreciara bien y se vera mal
  
    FormField<void>(
      validator: (_) {
        
        final val = controller?.text ?? '';
        final n = int.tryParse(val);
        if (val.isEmpty) return 'Obligatorio';
        if (n == null) return 'Solo números';
        return null;
      },
      builder: (state) => state.hasError ? Text(state.errorText!,style: TextStyle(color: Colors.red, fontSize: 11),) : SizedBox.shrink(), ),
    ],
  );
 }





Widget campo(String label, TextEditingController? controller,Color colorFondo, {bool obligatorio = false, bool readOnly = false}) {

  return TextFormField(           
    controller: controller,
    style: TextStyle(fontWeight: FontWeight.bold), 
    readOnly: readOnly, 
  
    validator: obligatorio ? validarCampoObligatorio : null,    
    decoration: _inputDeco(label, colorFondo)
  );
}

Widget campoDouble(String label, TextEditingController controller, Color colorFondo, {bool obligatorio = false}) {

  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    style: TextStyle(fontWeight: FontWeight.bold),
    
    decoration: _inputDeco(label, colorFondo),
    validator: (value) => validarDouble(value, obligatorio: obligatorio),
  );
}


InputDecoration _inputDeco(String label, Color color, {bool hint = false}) {

  return InputDecoration(
    labelText: hint ? null : label,
    hintText: hint ? label : null,

    labelStyle: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.bold),
    hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 13, fontWeight: FontWeight.bold),

    filled: true, //Hace falta poner el fillled para poder que funcione filledColor
    fillColor: color,

    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),

    //El por defecto, si falla alguno salta este y se usa 
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),

    //Borde cuando no se toca, en estado normal 
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFE8E8F0)),
    ),

    //Borde que se activa cuando escribes
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
    ),
    //Borde que se activa cuando hay error 
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFFF6584), width: 1.5),
    ),
  );
}



Widget campoStatSimple(String nombre, int valor) {

  int mod = ((valor - 10) / 2).floor();

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
        

        Text(
          "$valor  (${mod >= 0 ? '+' : ''}$mod)",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),

        SizedBox(width: 8),

        Expanded(child: Text(nombre, style: TextStyle(fontSize: 11, ),)),
      ],
    ),
  );
}

Widget campoHabilidad(String nombre, Personaje personaje) {

  //Asi diferencio si es una stats normal o es salvacion 

  final esSalvacion = ['FUE', 'DES', 'CON', 'INT', 'SAB', 'CAR'].contains(nombre);

  final valor     = esSalvacion ? personaje.modSalvacion(nombre) : personaje.modHabilidad(nombre);
  final tieneComp = esSalvacion ? personaje.tieneCompSalvacion(nombre) : personaje.tieneCompHabilidad(nombre);


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

        Text(esSalvacion ? "" : personaje.statDeHabilidad(nombre), style: TextStyle(fontSize: 11), textAlign: TextAlign.center),


      ],
    )
  );
}  