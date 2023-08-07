import 'package:fl_pokemon_list/pages/root_page.dart';
import 'package:fl_pokemon_list/utils/pokemon_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'utils/fetch_response.dart';
import 'utils/pokemon_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokemonRepository>(
          create: (context) => PokemonRepository(),
        ),
        ChangeNotifierProxyProvider<PokemonRepository, PokemonViewModel>(
          create: (context) => PokemonViewModel(
              repository:
                  Provider.of<PokemonRepository>(context, listen: false)),
          update: (context, repository, viewModel) =>
              PokemonViewModel(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        theme: ThemeData(
            primaryColor: Colors.black,
            primaryColorDark: Colors.black,
            scaffoldBackgroundColor: Color.fromARGB(255, 113, 113, 113)),
        home: Consumer<PokemonViewModel>(
          builder: (context, viewModel, child) {
            return FutureBuilder<FetchResponse>(
              future:
                  viewModel.fetchPokemons('https://pokeapi.co/api/v2/pokemon'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return ErrorWidget(snapshot.error!);
                  } else {
                    return RootPage(response: snapshot.data!);
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
