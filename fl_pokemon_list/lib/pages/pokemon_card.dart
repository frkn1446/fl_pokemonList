import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:flutter/material.dart';
import 'pokemon_detail_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonDisplayData pokemon;

  PokemonCard({required this.pokemon});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 171, 90),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              pokemon.pokemonName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetailPage(
                  pokemonImageUrl: pokemon.pokemonImageUrl,
                  pokemonImageUrl2: pokemon.pokemonImageUrl2,
                  name: pokemon.pokemonName,
                  height: pokemon.pokemonHeight,
                  weight: pokemon.pokemonWeight,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
