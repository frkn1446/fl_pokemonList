import 'package:flutter/cupertino.dart';
import 'fetch_response.dart';
import 'pokemon_model.dart';
import 'pokemon_repository.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<PokemonDisplayData> pokemonList = [];
  String nextUrl = "";
  bool isLoading = false;

  ScrollController get scrollController => _scrollController;

  Future<FetchResponse> fetchPokemons(String url) async {
    return await _repository.fetchData(url);
  }

  PokemonViewModel({required PokemonRepository repository})
      : _repository = repository;

  void loadMoreData() async {
    isLoading = true;
    notifyListeners();
    FetchResponse newResponse = await _repository.fetchData(nextUrl);
    pokemonList.addAll(newResponse.pokemonList);
    nextUrl = newResponse.nextUrl;
    isLoading = false;
    notifyListeners();
  }
}
