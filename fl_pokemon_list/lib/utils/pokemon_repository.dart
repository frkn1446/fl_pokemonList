import 'dart:convert';
import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'fetch_response.dart';

class PokemonRepository {
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
        final details = await http.get(Uri.parse(pokemonData['url']));
        String data2 = details.body;
        var decodedDetail = jsonDecode(data2);

        PokemonDisplayData pokemon = PokemonDisplayData(
          pokemonName: pokemonData['name'],
          pokemonImageUrl: decodedDetail['sprites']['front_shiny'],
          pokemonImageUrl2: decodedDetail['sprites']['other']['home']
              ['front_shiny'],
          pokemonHeight: decodedDetail['height'],
          pokemonWeight: decodedDetail['weight'],
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
