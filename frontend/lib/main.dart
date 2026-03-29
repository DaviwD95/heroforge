import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Login/cambiarPassword.dart';
import 'package:heroforge/Screens/Login/login.dart';
import 'package:heroforge/homePage.dart';
import 'package:heroforge/models/directorio_personajes.dart';
import 'package:heroforge/ViewModels/personajes_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}





class _MyAppState extends State<MyApp> {

  PersonajeViewModel? personajeViewModel;

  @override
  void initState() {    
    super.initState();

 
  }
  
 
   @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          
          create: (_) {

            personajeViewModel = PersonajeViewModel(DirectorioPersonajes()); // lo inicializamos vacio

            

          }
          
        ),
      ],

      child: MaterialApp(
        title: 'HeroForge',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateRoute: (settings) {
          
          final uri = Uri.base;

          //final uri = Uri.parse(settings.name ?? '/');

          if (uri.path == "/reset-password") {
            final token = uri.queryParameters["token"] ?? "";

            return MaterialPageRoute(
              builder: (_) => Cambiarpassword(token: token),
            );
          }

          return MaterialPageRoute(
            builder: (_) => Login(),
          );
        },
      ),
    );
  }
}



