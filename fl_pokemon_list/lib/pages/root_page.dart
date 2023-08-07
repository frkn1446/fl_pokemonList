import 'package:fl_pokemon_list/utils/fetch_response.dart';
import 'package:fl_pokemon_list/pages/pokemon_list_view.dart';
import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/pokemon_view_model.dart';

class RootPage extends StatefulWidget {
  final FetchResponse response;

  RootPage({required this.response});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late final PokemonViewModel _viewModel;

  getAppBar2() {
    return AppBar(
      backgroundColor: Colors.orange,
      elevation: 10,
      title: Text(
        "Pokemons",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  ScrollController _scrollController = ScrollController();
  List<PokemonDisplayData> pokemonList = [];
  String nextUrl = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<PokemonViewModel>(context, listen: false);
    _scrollController.addListener(_onScroll);
    pokemonList = widget.response.pokemonList;
    nextUrl = widget.response.nextUrl;
  }

  void _onScroll() async {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      setState(() {
        isLoading = true;
      });
      FetchResponse newResponse = await _viewModel.fetchPokemons(nextUrl);
      setState(() {
        pokemonList.addAll(newResponse.pokemonList);
        nextUrl = newResponse.nextUrl;
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar2(),
      body: Column(
        children: [
          Expanded(
            child: PokemonListView(
              pokemonList: pokemonList,
              // Bu satıra dikkat edin. ScrollController'ı ListView'a değil dışındaki Column'a aktardık.
              scrollController: _scrollController,
            ),
          ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            )
        ],
      ),
    );
  }
}
