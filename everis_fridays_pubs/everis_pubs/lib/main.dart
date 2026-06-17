import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:everis_pubs/models/pubs.dart';
import 'package:everis_pubs/pub_card.dart';

void main() => runApp(const EverisFridayApp());

class EverisFridayApp extends StatefulWidget {
  const EverisFridayApp({super.key});

  @override
  EverisFridayState createState() => EverisFridayState();
}

class EverisFridayState extends State<EverisFridayApp> {
  final List<Pubs> _listPubs = <Pubs>[];
  late Future<String> futurePubs;

  @override
  void initState() {
    super.initState();
    futurePubs = getPubs(_listPubs);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everis Fridays Pub',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Everis Fridays Pub'),
          backgroundColor: const Color(0xff9aae04),
        ),
        body: Center(
          child: _buildPubs(),
        ),
      ),
    );
  }

  Widget _buildPubs() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            projectSnap.hasData == false) {
          return const Text("Ups there is no data or connection");
        }
        return ListView.builder(
          itemCount: _listPubs.length,
          itemBuilder: (context, index) {
            return PubCard(_listPubs[index]);
          },
        );
      },
      future: futurePubs,
    );
  }

  Future<String> getPubs(List<Pubs> listPubs) async {
    final Response response =
        await get(Uri.parse('http://YOUR_LOCAL_IP:1337/api/pubs'));
    if (response.statusCode == 200) {
      List<dynamic> pubsListRaw = jsonDecode(response.body);
      for (var i = 0; i < pubsListRaw.length; i++) {
        listPubs.add(Pubs.fromJson(pubsListRaw[i]));
      }
      return "Success!";
    } else {
      throw Exception('Failed to load data');
    }
  }
}