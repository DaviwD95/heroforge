import 'package:flutter/material.dart';
import 'package:heroforge/Components/user_pop.dart';
import 'package:heroforge/Config/app_config.dart';
import 'package:heroforge/Screens/Listado/listado_personajes.dart';
import 'package:heroforge/Screens/dados.dart';
import 'package:heroforge/ViewModels/PersonajeViewModel.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _paginaActual = 1;
  
  late PersonajeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<PersonajeViewModel>(context, listen: false);
    viewModel.init(context);

    
  }

  @override
  Widget build(BuildContext context) {  

  final List<Widget> paginas = [
    Dados(), // índice 0
    Listadopersonajes(),                             // índice 1
  ];

    return Scaffold(
      backgroundColor: AppConfig.colorScaffold,

      appBar: AppBar(
        backgroundColor: AppConfig.colorAppBar,
        title: Text("HeroForge"),

        actions: [

          IconButton(onPressed: () { viewModel.addPersonaje(context);}, icon: Icon(Icons.add)),

          UserPop()

        ],
        
        ),  

      bottomNavigationBar: BottomNavigationBar(

         //backgroundColor: AppConfig.colorNavBar,
         //selectedItemColor: Colors.amber,
         //unselectedItemColor: Colors.white60,

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
