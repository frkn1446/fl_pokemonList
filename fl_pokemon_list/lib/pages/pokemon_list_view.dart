import 'package:fl_pokemon_list/pages/pokemon_card.dart';
import 'package:flutter/cupertino.dart';

import '../utils/pokemon_model.dart';

class PokemonListView extends StatelessWidget {
  final List<PokemonDisplayData> pokemonList;
  final ScrollController scrollController;

  PokemonListView({
    required this.pokemonList,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final PokemonDisplayData currentPokemon = pokemonList[index];
        return PokemonCard(pokemon: currentPokemon);
      },
    );
  }
}
