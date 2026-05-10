import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';

class TerminosCondiciones extends StatelessWidget {
  const TerminosCondiciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppConfig.colorScaffold,
      appBar: AppBar(

        backgroundColor: AppConfig.colorAppBar,

        title: Text("Terminos y Condiciones: HeroForge"),
      ),

      body: Padding(
        padding:EdgeInsetsGeometry.all(16),
         child: ListView(

          children: [

            Text("Terminos y Condiciones",  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, ),), 
            SizedBox(height: 20),            

            Text("1. Uso de la aplicación", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),               
            Text("HeroForge es una herramienta para crear y gestionar personajes de Dungeons & Dragons, pudiendo expandirse a futuro con más juegos de rol. El uso de la app es personal y no comercial."),
          
            SizedBox(height: 16),

            Text("2. Cuenta de usuario", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Eres responsable de mantener la seguridad de tu cuenta y contraseña. No compartas tus credenciales con terceros."),
            
            SizedBox(height: 16),

            Text("3. Contenido del usuario", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Los personajes y datos que crees son tuyos. HeroForge no se apropia de tu contenido ni lo comparte con terceros."),
            
            SizedBox(height: 16),

            Text("4. Propiedad intelectual", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("HeroForge no está afiliado ni patrocinado por Wizards of the Coast. Dungeons & Dragons es una marca registrada de Wizards of the Coast LLC."),
           
            SizedBox(height: 16),

            Text("5. Privacidad", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Solo almacenamos los datos necesarios para el funcionamiento de la app: email, contraseña cifrada y datos de tus personajes. No vendemos ni cedemos tus datos a terceros."),

            SizedBox(height: 16),

            Text("6. Disponibilidad", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("No garantizamos disponibilidad continua del servicio. Podemos modificar o interrumpir el servicio en cualquier momento."),

            SizedBox(height: 16),

            Text("7. Limitación de responsabilidad", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("HeroForge se ofrece tal cual, sin garantías de ningún tipo. No nos hacemos responsables de pérdida de datos."),

            SizedBox(height: 30),

            Text("Última actualización: Mayo 2025", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey),),
          ],
         ),),
    );
  }
}