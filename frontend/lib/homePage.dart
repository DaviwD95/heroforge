import 'package:flutter/material.dart';
import 'package:heroforge/Screens/Listado/ListadoPersonajes.dart';
import 'package:heroforge/ViewModels/personajes_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _paginaActual = 0;
  
  late PersonajeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<PersonajeViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {  

  final List<Widget> paginas = [
    const Center(child: Text("Pantalla de Dados")), // índice 0
    Listadopersonajes(),                             // índice 1
  ];

    return Scaffold(

      appBar: AppBar(title: Text("HeroForge")),  

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _paginaActual,

        onTap: (index) {
          setState(() {
            _paginaActual = index; // aquí se actualiza la página
          });
        },


        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.casino), label: "Dados", ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Personajes"),

        ],

      ),

      body: paginas[_paginaActual],
    );
  }
}
