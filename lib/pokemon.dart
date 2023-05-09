import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemon_details.dart';

class PokeHome extends StatefulWidget {
  const PokeHome({super.key});

  @override
  State<PokeHome> createState() => _PokeHomeState();
}

class Pokemon {
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List stats;
  final String type;

  Pokemon(
      {required this.name,
      required this.imageUrl,
      required this.height,
      required this.weight,
      required this.type,
      required this.stats});
}

Future<Pokemon> fetchRandomPokemon() async {
  final response = await http.get(Uri.parse(
      'https://pokeapi.co/api/v2/pokemon/${Random().nextInt(1010) + 1}'));
  print('pokemon');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final name = data['name'];
    final imageUrl = data['sprites']['front_default'];
    final height = data['height'];
    final weight = data['weight'];
    final type = data['types'][0]['type']['name'];
    final pokeType = type[0].toUpperCase() + type.substring(1);
    final pokeName = name[0].toUpperCase() + name.substring(1);
    final stats = data['stats'];

    return Pokemon(
        name: pokeName,
        imageUrl: imageUrl,
        height: height,
        weight: weight,
        type: pokeType,
        stats: stats
        );
  } else {
    throw Exception('Failed to fetch Pokemon');
  }
}

class _PokeHomeState extends State<PokeHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Pokédex App',
              style: TextStyle(
                  fontFamily: 'Lato', fontSize: 30, color: Colors.black),
            )),
        bottomNavigationBar:
            BottomAppBar(child: Container(height: 50, color: Colors.white)),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(10, (index) {
                return const RandomPokemonWidget();
              }),
            )));
  }
}

class RandomPokemonWidget extends StatelessWidget {
  const RandomPokemonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: fetchRandomPokemon(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data!;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailsPage(pokemon: pokemon),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(
                    pokemon.imageUrl,
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    pokemon.name,
                    style: const TextStyle(fontFamily: 'Lato'),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Transform.scale(
          scale: 0.2,
          child: const CircularProgressIndicator(),
        );
      },
    );
  }
}
