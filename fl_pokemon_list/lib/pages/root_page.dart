import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RootPage extends StatelessWidget {
  final List<PokemonDisplayData>
      pokemonList; // Burada pokemonData listesi bekliyoruz.

  RootPage({required this.pokemonList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final PokemonDisplayData currentPokemon = pokemonList[index];

          return Card(
            elevation: 0,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 171, 90),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                title: Center(
                  // Metni ortalamak için Center widget'ını kullanıyoruz.
                  child: Text(
                    currentPokemon.pokemonName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
                onTap: () {
                  // Burada tıklanan pokemonun detaylarına yönlendirebilirsiniz.
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

getAppBar() {
  return AppBar(
    backgroundColor: Colors.orange,
    elevation: 10,
    title: Text(
      "Pokemons",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
