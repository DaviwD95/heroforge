
import 'package:flutter/material.dart';
import 'package:heroforge/ViewModels/AuthViewModel.dart';




//PANTALLA DONDE SE CAMBIARA LA PASSWOD 
class Cambiarpassword extends StatefulWidget {

  final String token;
  const Cambiarpassword({super.key, required this.token});

  @override
  State<Cambiarpassword> createState() => _CambiarpasswordState();
}

class _CambiarpasswordState extends State<Cambiarpassword> {

  //Tokens backend 

  late  Authviewmodel vm;
  late String token;

  //Para formulario

  late TextEditingController  passwordNuevaController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();


    
    token = widget.token;
    
    vm = Authviewmodel();

    //formulario
    
    passwordNuevaController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.blueAccent),

      body: Form(
        key: _formKey,
        child: Column(
          children: [

            TextFormField(
              controller: passwordNuevaController,
              validator: _validarCampoObligatorio,

              decoration: InputDecoration(
                labelText: "Contraseña nueva",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

           //Boton para aceptar y hacer el cambio 

            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: cambiarPassword
                ,

                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  "Cambiar contraseña",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  String? _validarCampoObligatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  void cambiarPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool cambioCorrecto = await vm.resetPasswordBack(token, passwordNuevaController.text);

    if(cambioCorrecto == true)
    {

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contraseña cambiada correctamente"))
    );


    }else
    {

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error al cambiar contraseña"))
    );

    }




  }

}