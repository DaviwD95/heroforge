
import 'package:flutter/material.dart';
import 'package:heroforge/ViewModels/AuthViewModel.dart';



//ENVIAR UN EMAIL CON ENLACE PARA CAMBIAR 
class Recuperapassword extends StatefulWidget {
  const Recuperapassword({super.key});

  @override
  State<Recuperapassword> createState() => _RecuperapasswordState();
}

class _RecuperapasswordState extends State<Recuperapassword> {

  late Authviewmodel vm;
  late TextEditingController gmailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {


    super.initState();

    vm = Authviewmodel();

    gmailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),

      body: Form(
        key: _formKey,
        child: Column(
          children: [

            Text("Introduce el correo de tu cuenta"),
            
            const SizedBox(height: 30),

            TextFormField(
              controller: gmailController,
              validator: _validarCampoObligatorio,

              decoration: InputDecoration(
                labelText: "Gmail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

           //Boton para enviar el correo pues 
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: enviarEnlace,

                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  "Enviar enlace al correo",
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

void enviarEnlace() async{

    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool correoEnviado = await vm.rememberPasswordBack(gmailController.text);

    if(correoEnviado == true)
    {

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Correo enviado con exito"))
    );


    }else
    {

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error, verifica que el correo es el correcto"))
    );

    }
    

    
  }




}


