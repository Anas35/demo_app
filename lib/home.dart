import 'dart:async';

import 'package:demo_app/api.dart';
import 'package:demo_app/model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<PokemonStats>? pokemonStats;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check your Pokemon Stats'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: TextField(
              onChanged: (value) {
                if (timer?.isActive == true) {
                  timer?.cancel();
                }
                timer = Timer(const Duration(milliseconds: 5000), () {
                  pokemonStats = Api.getStats(value);
                  setState(() {});
                });
              },
            ),
          ),
          if (pokemonStats == null) ...{
            const Center(
              child: Text("Search the Pokemon"),
            ),
          } else ...{
            Expanded(
              child: FutureBuilder(
                future: pokemonStats,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 300,
                        height: 100,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(child: Image.network(snapshot.data!.url)),
                                    Expanded(child: Text('Name: ${snapshot.data!.name}')),
                                    Expanded(child: Text('Weight: ${snapshot.data!.weight}')),
                                  ],
                                ),
                                const Text("Abilites: "),
                                Wrap(
                                  spacing: 20.0,
                                  children: snapshot.data!.abilities.map((e) {
                                    return Text(e.name);
                                  }).toList(),                                
                                ),
                                const SizedBox(height: 20,),
                                const Text("Stats: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                Expanded(
                                  child: Wrap(
                                    spacing: 20.0,
                                    children: snapshot.data!.stats.map((e) {
                                      return Column(
                                        children: [
                                          Text('Base Stats: ${e.baseStat}'),
                                          Text('Effort: ${e.effort}'),
                                        ],
                                      );
                                    }).toList(),                                
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          }
        ],
      ),
    );
  }
}
