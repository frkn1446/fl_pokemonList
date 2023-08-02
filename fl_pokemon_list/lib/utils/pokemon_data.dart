import 'dart:convert';

import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:http/http.dart' as http;

class pokemonData {
  List<PokemonDisplayData> pokemonList = [];

  Future<List<PokemonDisplayData>> fetchData() async {
    String apiUrl = 'https://pokeapi.co/api/v2/pokemon';
    final response = await http.get(Uri.parse(apiUrl));
    List<PokemonDisplayData> fetchedList = [];

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      String _nextUrl = decodedData['next'];

      List<dynamic> results = decodedData['results'];

//      List<PokemonDisplayData> pokemonList = [];

      for (var pokemonData in results) {
        PokemonDisplayData pokemon = PokemonDisplayData(
          pokemonName: pokemonData['name'],
//  pokemonImage:,
//  pokemonHeight:,
//  pokemonWeight:,
        );
        fetchedList.add(pokemon);
        print(pokemon.pokemonName);
      }
      return fetchedList; // Her durumda bir liste döndürülüyor.
    } else {
      print('API veri alınamadı');
      return fetchedList; // Her durumda bir liste döndürülüyor.
    }
  }
}
