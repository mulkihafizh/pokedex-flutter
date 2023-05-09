import 'package:flutter/material.dart';
import 'pokemon.dart';

class PokemonType {
  static const Map<String, Color> typeColors = {
    'normal': Color.fromARGB(255, 168, 168, 120),
    'fire': Color.fromARGB(255, 240, 128, 48),
    'water': Color.fromARGB(255, 104, 144, 240),
    'grass': Color.fromARGB(255, 120, 200, 80),
    'electric': Color.fromARGB(255, 248, 208, 48),
    'ice': Color.fromARGB(255, 152, 216, 216),
    'fighting': Color.fromARGB(255, 192, 48, 40),
    'poison': Color.fromARGB(255, 160, 64, 160),
    'ground': Color.fromARGB(255, 224, 192, 104),
    'flying': Color.fromARGB(255, 168, 144, 240),
    'psychic': Color.fromARGB(255, 248, 88, 136),
    'bug': Color.fromARGB(255, 168, 184, 32),
    'rock': Color.fromARGB(255, 184, 160, 56),
    'ghost': Color.fromARGB(255, 112, 88, 152),
    'dragon': Color.fromARGB(255, 112, 56, 248),
    'dark': Color.fromARGB(255, 112, 88, 72),
    'steel': Color.fromARGB(255, 184, 184, 208),
    'fairy': Color.fromARGB(255, 238, 153, 172),
  };

  static const Map<String, String> typeImages = {
    'normal': 'assets/image/type/normal.png',
    'fire': 'assets/image/type/fire.png',
    'water': 'assets/image/type/water.png',
    'grass': 'assets/image/type/grass.png',
    'electric': 'assets/image/type/electric.png',
    'ice': 'assets/image/type/ice.png',
    'fighting': 'assets/image/type/fighting.png',
    'poison': 'assets/image/type/poison.png',
    'ground': 'assets/image/type/ground.png',
    'flying': 'assets/image/type/flying.png',
    'psychic': 'assets/image/type/psychic.png',
    'bug': 'assets/image/type/bug.png',
    'rock': 'assets/image/type/rock.png',
    'ghost': 'assets/image/type/ghost.png',
    'dragon': 'assets/image/type/dragon.png',
    'dark': 'assets/image/type/dark.png',
    'steel': 'assets/image/type/steel.png',
    'fairy': 'assets/image/type/fairy.png',
  };
}

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final double _height = 150.0;
  late final Pokemon pokemon;
  int navIndex = 0;
  var listWidget = [];

  @override
  void initState() {
    super.initState();
    pokemon = widget.pokemon;
    listWidget = [
      Stats(),
      const Text('Evolution'),
      const Text('Moves'),
    ];
    print(pokemon.stats[0]['base_stat']);
  }

  Widget Stats() {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pokemon.stats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              pokemon.stats[index]['stat']['name'].toUpperCase(),
              style: const TextStyle(fontFamily: 'Lato'),
            ),
            subtitle: Text(
              pokemon.stats[index]['base_stat'].toString(),
              style: const TextStyle(fontFamily: 'Lato'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            PokemonType.typeColors[pokemon.type.toLowerCase()] ?? Colors.grey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Lato', color: Colors.black),
          child: ListView(
            children: [
              Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 100.0),
                      color: Colors.transparent,
                      child: Container(
                        height: _height,
                        width: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    Positioned(
                      top: _height - 50,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                                scale: 1.6,
                                child: Image.network(
                                  pokemon.imageUrl,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              pokemon.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                            color: PokemonType
                                    .typeColors[pokemon.type.toLowerCase()] ??
                                Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: PokemonType.typeColors[
                                        pokemon.type.toLowerCase()] ??
                                    Colors.grey,
                                blurRadius: 10,
                              )
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  PokemonType.typeImages[
                                          pokemon.type.toLowerCase()] ??
                                      '',
                                ),
                              ),
                              Text(
                                pokemon.type,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: navIndex == 0
                                    ? MaterialStateProperty.all(
                                        PokemonType.typeColors[
                                                pokemon.type.toLowerCase()] ??
                                            Colors.grey,
                                      )
                                    : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  navIndex = 0;
                                });
                              },
                              child: Text(
                                'STATS',
                                style: TextStyle(
                                  color: navIndex == 0
                                      ? Colors.white
                                      : PokemonType.typeColors[
                                              pokemon.type.toLowerCase()] ??
                                          Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: navIndex == 1
                                    ? MaterialStateProperty.all(
                                        PokemonType.typeColors[
                                                pokemon.type.toLowerCase()] ??
                                            Colors.grey,
                                      )
                                    : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  navIndex = 1;
                                });
                              },
                              child: Text(
                                'EVOLUTION',
                                style: TextStyle(
                                  color: navIndex == 1
                                      ? Colors.white
                                      : PokemonType.typeColors[
                                              pokemon.type.toLowerCase()] ??
                                          Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: navIndex == 2
                                    ? MaterialStateProperty.all(
                                        PokemonType.typeColors[
                                                pokemon.type.toLowerCase()] ??
                                            Colors.grey,
                                      )
                                    : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  navIndex = 2;
                                });
                              },
                              child: Text(
                                'MOVES',
                                style: TextStyle(
                                  color: navIndex == 2
                                      ? Colors.white
                                      : PokemonType.typeColors[
                                              pokemon.type.toLowerCase()] ??
                                          Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: listWidget[navIndex],
                    )
                  ],
                ),
            ],
          ),
        ));
  }
}

Widget Evolution() {
  return Text('Evolution');
}

Widget Moves() {
  return Text('Moves');
}
