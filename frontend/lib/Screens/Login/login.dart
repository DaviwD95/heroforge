
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/Screens/Login/recupera_password.dart';
import 'package:heroforge/Screens/Sign/sign_in.dart';

import 'package:heroforge/ViewModels/AuthViewModel.dart';
import 'package:heroforge/Screens/Home/home_page.dart';
import 'package:heroforge/models/Auth/auth_provider.dart';
import 'package:heroforge/models/Auth/usuario.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: AppConfig.colorScaffold,

        appBar: AppBar(
          backgroundColor: AppConfig.colorAppBar,        
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

  void loguearse() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final result = await vm.loginBack(gmailController.text.trim(), passwordController.text.trim());

    if(result != null)
    {
       


        String token = result["access_token"]; 

        final user = Usuario.fromJson(result["user"]);

        
        Provider.of<AuthProvider>(context, listen: false).login(token, user);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()),);

    }else
    {
       ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Error, credenciales incorrectas")));

    }

  } 



}
