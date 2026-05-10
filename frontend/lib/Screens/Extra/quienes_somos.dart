import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';

class QuienesSomos extends StatelessWidget {
  const QuienesSomos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        title: Text("¿ Quienes somos..... ? "),
        backgroundColor:  AppConfig.colorAppBar,
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: ListView(

          children: [

            Text(
              "HeroForge",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),

            Text(
              "¿Quiénes somos?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            SizedBox(height: 8),

            Divider(color: Colors.deepPurple, thickness: 3),

            SizedBox(height: 24),

            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/Yo/mimis.jpg"),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "David Alejandro García Quintero",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),

            SizedBox(height: 6),

            Text(
              "Estudiante de Desarrollo de Aplicaciones Multiplataformas en IES Portada Alta",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            SizedBox(height: 24),

            Divider(color: Colors.deepPurple.shade100),

            SizedBox(height: 16),

            Text(
              "Sobre HeroForge",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),

            SizedBox(height: 8),

            Text(
              "HeroForge nació como proyecto de fin de curso con el objetivo de facilitar la creación y gestión de personajes para juegos de rol como Dungeons & Dragons. Una app hecha por un jugador, para jugadores.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 30),

            Divider(color: Colors.deepPurple, thickness: 1),

            SizedBox(height: 8),

            Text(
              "HeroForge © 2025",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

          ],




        ),),
    );
  }
}