import 'pokemon_model.dart';

class FetchResponse {
  final List<PokemonDisplayData> pokemonList;
  final String nextUrl;

  FetchResponse({required this.pokemonList, required this.nextUrl});
}
