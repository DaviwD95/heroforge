import 'package:flutter/material.dart';
import 'package:heroforge/Config/app_config.dart';

class Glosario extends StatelessWidget {
  const Glosario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        title: Text("Glosario de Términos"),
        backgroundColor: AppConfig.colorAppBar,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            Text(
              "Glosario de Términos",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Dungeon Master (DM)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Persona que dirige la partida, controla enemigos, NPCs y la historia.",
            ),

            SizedBox(height: 16),

            Text(
              "Tirada de Salvación",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Tirada para resistir efectos como magia, veneno o trampas.",
            ),

            SizedBox(height: 16),

            Text(
              "Estadísticas",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Son los atributos principales del personaje: Fuerza, Destreza, Constitución, Inteligencia, Sabiduría y Carisma.",
            ),

            SizedBox(height: 16),

            Text(
              "Stats Secundarias",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Son valores derivados de las estadísticas principales, como iniciativa, velocidad, percepción pasiva o clase de armadura.",
            ),

            SizedBox(height: 16),

            Text(
              "Iniciativa",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Define el orden de turnos en combate. Se calcula con 1d20 + modificador de Destreza.",
            ),

            SizedBox(height: 16),

            Text(
              "Velocidad",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Cantidad de movimiento que puede hacer un personaje por turno. Normalmente 30 pies.",
            ),

            SizedBox(height: 16),

            Text(
              "Clase de Armadura (CA)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Número que determina qué tan difícil es golpear al personaje.",
            ),

            SizedBox(height: 16),

            Text(
              "Puntos de Golpe (HP)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Representan la vida del personaje.",
            ),

            SizedBox(height: 16),

            Text(
              "Bonificador de Competencia",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Bono que aumenta con el nivel y mejora habilidades, ataques y salvaciones.",
            ),

            SizedBox(height: 16),

            Text(
              "NPC",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Personaje no jugable controlado por el Dungeon Master.",
            ),

            SizedBox(height: 16),

            Text(
              "Campaña",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Historia larga formada por múltiples sesiones.",
            ),

            SizedBox(height: 16),

            Text(
              "One Shot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Aventura corta diseñada para jugarse en una sola sesión.",
            ),

            SizedBox(height: 30),

            Text(
              "HeroForge - Glosario Básico D&D",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
        
        
          ],
        ),
      ),
    );
  }
}