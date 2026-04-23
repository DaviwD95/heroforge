import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Listado/PersonajeTile.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/Personaje.dart';
import 'package:provider/provider.dart';

class Listadopersonajes extends StatefulWidget {
  const Listadopersonajes({super.key});

  @override
  State<Listadopersonajes> createState() => _ListadopersonajesState();
}

class _ListadopersonajesState extends State<Listadopersonajes> {

  late PersonajeViewModel viewModel;

  @override
  void initState() {

    super.initState();
    viewModel = Provider.of<PersonajeViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListenableBuilder(
      
        listenable: viewModel.directorio,
      
        builder: (context, _) {
      
          return ListView.builder(
      
            itemBuilder: (context, index) {
              Personaje personaje = viewModel.directorio.personajes[index];
      
              return ListenableBuilder(
      
                listenable: personaje,
                builder: (context, child) {
      
                  return Personajetile(personaje: personaje);
                  
                },
              );
            },
            itemCount: viewModel.numPersonajes,
          );
        },
      ),
    );
  }
}
