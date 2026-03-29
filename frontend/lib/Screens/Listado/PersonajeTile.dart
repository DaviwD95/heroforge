import 'package:flutter/material.dart';
import 'package:heroforge/models/personaje.dart';

class Personajetile extends StatefulWidget {
  final Personaje personaje;
  const Personajetile({super.key, required this.personaje});

  @override
  State<Personajetile> createState() => _PersonajetileState();
}

class _PersonajetileState extends State<Personajetile> {




  @override
  Widget build(BuildContext context) {

    return  ListTile(


      title: Row(children: [

        Text(widget.personaje.nombre ?? "") ,

        Text(widget.personaje.raza ?? "")
      ],),

      subtitle: Text(widget.personaje.clase ?? ""),
    );
  }
}