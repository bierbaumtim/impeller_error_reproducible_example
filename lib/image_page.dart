import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    required this.onToggleShowPerformanceOverlay,
  });

  final VoidCallback onToggleShowPerformanceOverlay;

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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Impeller'),
          trailing: CupertinoButton(
            onPressed: onToggleShowPerformanceOverlay,
            child: const Icon(CupertinoIcons.graph_square),
          ),
        ),
        child: FutureBuilder<List<String>>(
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
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Impeller'),
    //   ),
    //   body: FutureBuilder<List<String>>(
    //     future: _loadImagePage,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return VisibilityDetector(
    //           key: const ValueKey('test'),
    //           onVisibilityChanged: (info) {},
    //           child: LazyLoadScrollView(
    //             child: ListView.builder(
    //               itemCount: snapshot.data!.length,
    //               itemBuilder: (context, index) => _ImageCard(
    //                 url: snapshot.data!.elementAt(index),
    //               ),
    //             ),
    //             onEndOfPage: () async => await Future.delayed(
    //               const Duration(milliseconds: 1500),
    //             ),
    //           ),
    //         );
    //       }

    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    // );
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemGroupedBackground
            .resolveFrom(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: url,
            height: 200,
            memCacheHeight: 300,
            maxHeightDiskCache: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorWidget: (context, url, dynamic error) => Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: const Center(
                child: Text('Bild konnte nicht geladen werden'),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Bild wird geladen'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
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
    // return Card(
    //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //   clipBehavior: Clip.antiAlias,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       CachedNetworkImage(
    //         imageUrl: url,
    //         height: 200,
    //         memCacheHeight: 300,
    //         maxHeightDiskCache: 300,
    //         width: double.infinity,
    //         fit: BoxFit.cover,
    //         errorWidget: (context, url, dynamic error) => Container(
    //           height: 200,
    //           padding: const EdgeInsets.symmetric(horizontal: 12.0),
    //           child: const Center(
    //             child: Text('Bild konnte nicht geladen werden'),
    //           ),
    //         ),
    //         placeholder: (context, url) => Container(
    //           height: 200,
    //           padding: const EdgeInsets.symmetric(horizontal: 12),
    //           child: Center(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: const [
    //                 CircularProgressIndicator(),
    //                 Text('Bild wird geladen'),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: const [
    //             Text(
    //               'Lorem ipsum dolor sit amet, consetetur sadipscing elitr',
    //               style: TextStyle(
    //                 fontSize: 17.5,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //               maxLines: 2,
    //               textAlign: TextAlign.left,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             Text(
    //               'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
    //               'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, '
    //               'sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum',
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 height: 1.2,
    //               ),
    //               maxLines: 5,
    //               overflow: TextOverflow.ellipsis,
    //               textAlign: TextAlign.justify,
    //               softWrap: true,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
