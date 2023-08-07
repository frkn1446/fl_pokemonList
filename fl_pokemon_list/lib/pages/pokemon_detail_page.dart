import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  final String pokemonImageUrl;
  final String pokemonImageUrl2;
  final String name;
  final int height;
  final int weight;

  PokemonDetailPage({
    required this.pokemonImageUrl,
    required this.pokemonImageUrl2,
    required this.name,
    required this.height,
    required this.weight,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sol üstte normal boyutta pokemonImageUrl fotoğrafı
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pokemonImageUrl),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Altında büyük şekilde pokemonImageUrl2 fotoğrafı
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pokemonImageUrl2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // İsim
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Boy
              Text(
                "Height: $height",
                style: TextStyle(fontSize: 18),
              ),
              // Ağırlık
              Text(
                "Weight: $weight",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getAppBar() {
  return AppBar(
    backgroundColor: Colors.orange,
    elevation: 10,
    title: Text(
      "Pokemon Details",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
