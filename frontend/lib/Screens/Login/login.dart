
import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Login/recuperaPassword.dart';
import 'package:heroforge/Screens/Sign/signIn.dart';

import 'package:heroforge/ViewModels/AuthViewModel.dart';
import 'package:heroforge/homePage.dart';

class Login extends StatefulWidget {


  const Login({super.key});

  @override
  State<Login> createState() => _LoginsignState();
}

class _LoginsignState extends State<Login> {
  
  late Authviewmodel vm;
  late TextEditingController gmailController, passwordController;
  final _formKey = GlobalKey<FormState>();
  bool passwordOculta= false;
  @override
  void initState() {
    super.initState();

    vm = Authviewmodel();

    gmailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    

    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.blueAccent,          
        ),

        body:  Padding(
          
            padding: const EdgeInsets.all(8.0),
          
            child: Form(
              key: _formKey,
          
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
          
                  children: [
                    Text(
                      "Login",
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
                        validator: _validarCampoObligatorio,
          
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
                        obscureText: passwordOculta,
          
                        decoration: 
                        InputDecoration(
          
                          suffixIcon: 
                            IconButton
                            ( 
                              icon: Icon(passwordOculta ? Icons.visibility : Icons.visibility_off,),
          
                              onPressed: () {
                                setState(() {
                                  passwordOculta = !passwordOculta;
                                  
                                });
                                
                                },
                              
                            ),
                          
                          labelText: "Contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 30),
          
                    /// Boton para loguearse
                    SizedBox(
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: loguearse,
          
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
          
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),          
                    
          
                    SizedBox(height: 20),          
          
                     TextButton(
                      onPressed: () {
                        
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Recuperapassword()),);
                        
                        },
                      child: Text("¿Has olvidado tu contraseña? pulsa aqui  ",
                      
                      style: TextStyle(
                        
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),),                
                      
                    ),
          
                     const SizedBox(height: 30),
          
                    TextButton(
                      onPressed: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign()),);
                        
                        },
                      child: Text("¿No tienes una cuenta aun? registrate pulsando aqui",
                      
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

  String? _validarCampoObligatorio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  void loguearse() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final results = await vm.loginBack(gmailController.text.trim(), passwordController.text.trim());

    if(results != null)
    {
        String token = results["access_token"]; // lo guardo para mas adelante que seguro tendre que ir pasando

       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()),);
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Placeholder()),);

    }else
    {
       ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error, credenciales incorrectas")));

    }

  } 



}
