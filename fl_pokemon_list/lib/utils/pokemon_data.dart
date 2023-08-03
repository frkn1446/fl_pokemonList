import 'dart:convert';

import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:http/http.dart' as http;

import 'fetch_response.dart';

class pokemonData {
  Future<FetchResponse> fetchData(String _nextUrl) async {
    String apiUrl = _nextUrl;
    final response = await http.get(Uri.parse(apiUrl));
    List<PokemonDisplayData> fetchedList = [];

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      String _nextUrl = decodedData['next'];
      print(_nextUrl);
      List<dynamic> results = decodedData['results'];

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
      return FetchResponse(pokemonList: fetchedList, nextUrl: _nextUrl);
    } else {
      print('API veri alınamadı');
      return FetchResponse(pokemonList: fetchedList, nextUrl: '');
    }
  }
}
