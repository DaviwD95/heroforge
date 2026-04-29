
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/Screens/Login/cambiar_password.dart';

import 'package:heroforge/Screens/Login/login.dart';
import 'package:heroforge/ViewModels/AuthViewModel.dart';
import 'package:heroforge/models/Auth/auth_provider.dart';
import 'package:heroforge/models/Auth/usuario.dart';
import 'package:image_picker/image_picker.dart';


import 'package:provider/provider.dart';


class Perfil extends StatefulWidget {
  
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  late Authviewmodel vm;
  late Usuario? user;

  @override
  void initState() {    
    super.initState();
    
    vm =  Authviewmodel();
    user = Provider.of<AuthProvider>(context, listen: false).user;


  } 
  // para mostrar instantaneamente la foto al cambiarse y poder seleccionar bien la foto segun la plataforma 

  File? _imagenFile;
  Uint8List? _imagenBytes; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
                
        backgroundColor: AppConfig.colorScaffold,

        appBar: AppBar(
          backgroundColor: AppConfig.colorAppBar, title: Text('Perfil')
          ),

        body: ListView(

          padding: const EdgeInsets.all(20),
        
          children: [
            
            GestureDetector(
              onTap: () async 
              {
                await _seleccionarImagen();
              },       
               
              
                child:  CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey[200],                  

                 child: ClipOval(child: SizedBox(width: 110, height: 110, child: _buildImage(), ),),)        
            ),

            Card(

               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
               elevation: 3,

               child: ListenableBuilder(
                listenable: Provider.of<AuthProvider>(context),
                builder: (context, _)
                {
                  //NO uso el de init state por que es no va cambiando, nomralmente tengo una lista con notify, 
                  //podria hacer el user tambien con un notify pero bueno 
                  
                 
                  return Column(
                 
                  children: [
                 
                    ListTile(

                      title: Text(user?.nombre ?? ""),
                      leading: Icon(Icons.person),
                      trailing: IconButton(onPressed: () {

                        _editarCampo("Editar nombre", user?.nombre ?? "", vm.cambiarNombre, _validarCampoObligatorio);

                        }, 
                      icon: Icon(Icons.edit)),
                 
                    ),
                 
                    Divider(),
                 
                     ListTile(
                      title: Text(user?.email ?? ""),
                      leading: Icon(Icons.email),
                      trailing: IconButton(onPressed: () {

                        _editarCampo("Editar email", user?.email ?? "", vm.cambiarEmail, _validarEmail);


                      }, icon: Icon(Icons.edit)),
                 
                    ),
                 
                    Divider(),
                 
                     ListTile(
                      title: Text(user?.role ?? ""),
                      leading: Icon(Icons.badge),
                    ),            
                    
                 
                    Divider(),          
                     
                 
                  ],
                  );
                }
                 
               ),



            ),    

            ElevatedButton.icon(

              style: ElevatedButton.styleFrom(

                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),),
                ),
              onPressed: () {
            
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => Cambiarpassword(token: Provider.of<AuthProvider>(context, listen: false).token ?? "")),);
                
              },
              icon: Icon(Icons.lock),
              label: Text("Cambiar contraseña"),
              
              ) ,        

            Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),

                child: TextButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();

                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()),(route) => false,);
                  },
                  child: Text(
                    "Cerrar sesion",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ) 



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



  String? _validarEmail(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }

    if (!EmailValidator.validate(value)) {
      return "El email no es valido";
    }
    return null;
  }

  Future<void> _seleccionarImagen() async 
  {

   final picker = ImagePicker();

   //Selleccionar la imagen de la galeria
   final XFile? image = await picker.pickImage(
     source: ImageSource.gallery,
     imageQuality: 70,
     maxWidth: 300,
     maxHeight: 300,
   );

   //Si no se selecciona nada pues no devolvemos nada
   if (image == null) return;

   if (kIsWeb) {

    //En web se usa el bytes, ya que no se tiene acceso tan facil a los archivos, en android usamos FIle
    final bytes = await image.readAsBytes();

    setState(() {
      _imagenBytes = bytes;
      _imagenFile = null;
    });

    bool? cambio = await vm.cambiarFotoUrl(null, _imagenBytes, context);

   if(cambio == true)
   {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado la foto de perfil con exito!")),);
   }else
   {
     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal al cambiar la foto de perfil")),);
   }

   } else 
   {

     setState(() {
     _imagenFile = File(image.path);
     _imagenBytes = null;
     });

    bool? cambio = await vm.cambiarFotoUrl(_imagenFile, null, context);

    if(cambio == true)
    {
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Se ha cambiado la foto de perfil con exito!")),);
    }else
    {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Error, algo salio mal al cambiar la foto de perfil")),);
    }
    
  }
}

  Widget _buildImage() {
   
    //Estos if hacen falta pars mostrar instantaneamente la foto al cambiarse, 

    if (_imagenBytes != null) {
        return Image.memory(
          _imagenBytes!,
          fit: BoxFit.cover,
    );
    } else if (_imagenFile != null) {
      return Image.file(
        _imagenFile!,
        fit: BoxFit.cover,
    );
  } else if (user?.fotoUrl != null) {

    
     final url = Provider.of<AuthProvider>(context, listen: false).fotoUrlConCache;

     return Image.network("$url",fit: BoxFit.cover,);   
    
  } else {
    return Center(
      child: Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }
}

//MAs comodo y asi no repito tanto
Future<void> _editarCampo(String titulo, String? valorInicial,  Future<bool?> Function(String, BuildContext) onGuardar, String? Function(String?) validator) async {

  final formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController(text: valorInicial);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(

      content: Form(
        key: formKey,

        child: TextFormField(
          controller: controller,
          validator : validator,     
        
           decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),
      title: Text(titulo),
      actions: [

        TextButton(onPressed: () {

          Navigator.pop(context);
          
        }, child: Text("Cancelar")),
        
        TextButton(onPressed: () async {

          if (formKey.currentState!.validate()) { 

            await onGuardar(controller.text, context);

            Navigator.pop(context);
            }

        }, child: Text("Guardar ")),

      ],





    )
    );
}

}
