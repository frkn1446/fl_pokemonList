import 'package:flutter/cupertino.dart';
import 'fetch_response.dart';
import 'pokemon_model.dart';
import 'pokemon_repository.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<PokemonDisplayData> pokemonList = [];
  String nextUrl = "";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isAtBottom = false; // Liste sonunda olduğunu belirten durum değişkeni

  void checkIsAtBottom() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      isAtBottom = true;
    } else {
      isAtBottom = false;
    }
    notifyListeners();
  }

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
