
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/AppConfig.dart';
import 'package:heroforge/Screens/Login/login.dart';
import 'package:heroforge/ViewModels/AuthViewModel.dart';

class Sign extends StatefulWidget {

  const Sign({super.key});

  @override
  State<Sign> createState() => _LoginsignState();
}

class _LoginsignState extends State<Sign> {

  late TextEditingController gmailController, passwordController, nombreController;
  final _formKey = GlobalKey<FormState>();
   late Authviewmodel vm;

  @override
  void initState() {
    super.initState();

    vm = Authviewmodel();

    gmailController = TextEditingController();
    passwordController = TextEditingController();
    nombreController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: AppConfig.colorScaffold,

        appBar: AppBar(
          backgroundColor: AppConfig.colorAppBar,          
        ),

        body: Padding(

          padding: const EdgeInsets.all(8.0),

          child: Form(
            key: _formKey,

            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: gmailController,
                      validator: _validarEmail,

                      decoration: InputDecoration(
                        labelText: "Gmail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: passwordController,
                      validator: _validarCampoObligatorio,

                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: nombreController,
                      validator: _validarCampoObligatorio,

                      decoration: InputDecoration(
                        labelText: "Nombre",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Boton para Crearse la cuenta 
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: guardarCambios,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: const Text(
                        "Crear cuenta",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),                 

                  
                  const SizedBox(height: 30),

                  TextButton(
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()),);},
                    child: Text("¿Ya tienes una cuenta? Inicia sesion pulsando aqui",
                    
                    style: TextStyle(
                      
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),),                
                    
                  )



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validarEmail(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }

    if (!EmailValidator.validate(value)) {
      return "El email no es valido";
    }
    return null;
  }

  String? _validarCampoObligatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  void guardarCambios() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool ok = await vm.signBack(
    gmailController.text,
    passwordController.text,
    nombreController.text,
  );
  

    if (ok == true) {
      
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Registrado correctamente")),);

      Navigator.of(context).pop(true);

    } else  {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, ese email ya esta en uso")),);
    }

    
  }
}
