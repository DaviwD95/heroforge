 import 'package:flutter/material.dart';





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


String? validarCampoObligatorio(String? value) {
  
  
  if (value == null || value.trim().isEmpty) {
    return "Este campo es obligatorio";
  }
  return null;
}


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




Widget campo(String label, TextEditingController controller,Color colorFondo, {bool obligatorio = false, bool readOnly = false}) {

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

    //Para que sirve ? 
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xFFE0E0E0)),
    ),

    //Para que sirve 
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