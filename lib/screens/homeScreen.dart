// import 'package:cuaca/service/globals.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:cuaca/service/serverApi.dart';

var list;

class homeScreen extends StatefulWidget {
  static const String id = "galeryScreen";

  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    super.initState();
    // tweets();
    // serverApi.instance.playerGalery(players[0]["citizenid"]);
  }

  // Future<List<dynamic>> tweets() async {
  //   final http.Response response = await http.get(
  //     Uri.parse("${BaseURL.apiAddress}/phone_tweets"),
  //   );

  //   if (response.statusCode == 200) {
  //     list = json.decode(response.body);
  //     print(list);
  //     return [response.body];
  //   } else {
  //     return [];
  //   }
  // }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);

    Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tweet'),
      ),
      // body: list.isEmpty
      //     ? const Center(
      //         // Tampilkan pesan jika galeri kosong
      //         child: Text('Galeri kosong'),
      //       )
      //     : ListView.builder(
      //         itemCount: list.length,
      //         itemBuilder: (context, index) {
      //           // Mengambil URL gambar dari data galeri
      //           String imageUrl = list[index]['url'];
      //           return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(
      //                             list[index]['firstName'],
      //                             style: const TextStyle(
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                           const SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(
      //                             list[index]['lastName'],
      //                             style: const TextStyle(
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                         ],
      //                       ),
      //                       Text(
      //                         formatDate(list[index]['date']),
      //                         style:
      //                             const TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                   Row(
      //                     children: [
      //                       Text(
      //                         list[index]['message'],
      //                         style:
      //                             const TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   imageUrl != ""
      //                       ? Image.network(
      //                           imageUrl,
      //                           fit: BoxFit
      //                               .cover, // Agar gambar memenuhi ruang yang tersedia
      //                         )
      //                       : Container()
      //                 ],
      //               ));
      //         },
      //       ),
    );
  }
}
