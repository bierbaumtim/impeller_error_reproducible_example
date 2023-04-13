import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  Future<List<String>> get _loadImagePage async {
    final res = await http.get(
      Uri.parse("https://picsum.photos/v2/list?limit=50"),
    );

    final json = jsonDecode(res.body) as List;

    return json
        .map<String>(
          (e) => (e as Map<String, dynamic>)['download_url'] as String,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impeller'),
      ),
      body: FutureBuilder<List<String>>(
        future: _loadImagePage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => _ImageCard(
                url: snapshot.data!.elementAt(index),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({
    // ignore: unused_element
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            url,
            height: 200,
            cacheHeight: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr',
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                  'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, '
                  'sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.2,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
