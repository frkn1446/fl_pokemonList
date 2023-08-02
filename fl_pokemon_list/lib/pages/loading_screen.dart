import 'package:fl_pokemon_list/utils/pokemon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'root_page.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pokemonData().fetchData().then((fetchedPokemons) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootPage(pokemonList: fetchedPokemons),
          ));
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 52, 255, 58),
              Color.fromARGB(255, 251, 20, 4)
            ],
          ),
        ),
        child: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 150,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}

getAppBar() {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 10,
    title: Text(
      "Pokemons",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
