import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Listado/personaje_tile.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:heroforge/models/personaje.dart';
import 'package:provider/provider.dart';

class ListadoPersonajesPublicados extends StatefulWidget {
  const ListadoPersonajesPublicados({super.key});

  @override
  State<ListadoPersonajesPublicados> createState() => _ListadopersonajesState();
}

class _ListadopersonajesState extends State<ListadoPersonajesPublicados> {

  

  late PersonajeViewModel viewModel;

  @override
  void initState() {

    super.initState();
    viewModel = Provider.of<PersonajeViewModel>(context, listen: false);

    /**
    * Se realiza la carga cada vez que se entra a la pantalla para garantizar
    * que los personajes publicados por otros usuarios mientras tanto
    * sean visibles sin necesidad de reiniciar la app.
    */

    viewModel.getPersonajesPublicados(context);
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListenableBuilder(
      
        listenable: viewModel.directorioPersonajesPublicados,
      
        builder: (context, _) {
      
          return ListView.builder(
            itemCount: viewModel.directorioPersonajesPublicados.personajes.length,
      
            itemBuilder: (context, index) {
              Personaje personaje = viewModel.directorioPersonajesPublicados.personajes[index];
      
              return ListenableBuilder(
      
                listenable: personaje,
                builder: (context, child) {
      
                  return Personajetile(personaje: personaje, modificable: false,);
                  
                },
              );
            },

          );
        },
      ),
    );
  }
}
