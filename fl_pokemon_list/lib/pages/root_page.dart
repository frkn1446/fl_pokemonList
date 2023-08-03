import 'package:fl_pokemon_list/utils/fetch_response.dart';
import 'package:fl_pokemon_list/utils/pokemon_data.dart';
import 'package:fl_pokemon_list/utils/pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RootPage extends StatefulWidget {
  final FetchResponse response;

  RootPage({required this.response});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  ScrollController _scrollController = ScrollController();
  // ScrollController, ListView'in kaydırma durumunu izlemek için kullanılır.
  List<PokemonDisplayData> pokemonList = [];
  String nextUrl = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    pokemonList = widget.response.pokemonList;
    nextUrl = widget.response.nextUrl;
    // ScrollController'a bir dinleyici ekleyerek kullanıcının listenin
    //sonuna geldiğini algılamak için _onScroll fonksiyonunu çağırırız.
  }

  void _onScroll() async {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      FetchResponse newResponse = await pokemonData().fetchData(nextUrl);
      setState(() {
        pokemonList.addAll(newResponse.pokemonList);
        nextUrl = newResponse.nextUrl;
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
      appBar: getAppBar(),
      body: ListView.builder(
        controller: _scrollController, // ScrollController'ı ekliyoruz
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final PokemonDisplayData currentPokemon = pokemonList[index];

          return Card(
            elevation: 10,
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
