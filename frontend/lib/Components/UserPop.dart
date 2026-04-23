

import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Home/Perfil.dart';
import 'package:heroforge/Screens/Login/login.dart';
import 'package:heroforge/models/Auth/AuthProvider.dart';
import 'package:heroforge/models/Auth/Usuario.dart';
import 'package:provider/provider.dart';



class UserPop extends StatelessWidget {
  const UserPop({super.key,});
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return PopupMenuButton(
      
    
      icon:  CircleAvatar(radius: 30,child: ClipOval(child: SizedBox(width: 110, height: 110, child: _buildImage(user, context)),),),
      
      itemBuilder:(context)
      {
        return [
          PopupMenuItem(
            
            height: 60,
            child: SizedBox(
              width: 350,
              child: Padding(
    
                padding: const EdgeInsets.all(16.0),
    
                child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  children: [
                
                    InkWell(
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipOval(child: SizedBox(width: 110, height: 110, child: _buildImage(user, context)),),
                      ),

                      onTap: () async { 

                        Navigator.pop(context);
                        
                        await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Perfil()),);

                        },
                    ),
    
                    SizedBox(height: 10),
                
                    Text(user!.nombre),
    
                    SizedBox(height: 5),
                
                    Text(user.email),
    
                    SizedBox(height: 10),                    
                    
                    Card(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(12)), 
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
    
                      child: TextButton( onPressed: () {
    
                        Provider.of<AuthProvider>(context, listen: false).logout();
    
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false,);
                      }, child: Text("Cerrar sesion", style: TextStyle(color: Colors.white),),  ),
                    ))
                  ],
                ),
              ),
            )                  
            )
        ];
      });

  }

  //Este widget me ayuda a crear la imagen,evitando pedir mcuhas veces al backend la foto si es innecesario

  Widget _buildImage(Usuario? user, BuildContext context) {     
    
   if (user?.fotoUrl != null) {

     final url = Provider.of<AuthProvider>(context, listen: false).fotoUrlConCache;

     return Image.network("$url",fit: BoxFit.cover,);
   
  } else {
    return Center(
      child: Icon(Icons.person, size: 50, color: Colors.grey),
    );
  }
}
}