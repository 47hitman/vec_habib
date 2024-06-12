import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:vec_habib/screens/webview.dart';

var list;

class homeScreen extends StatefulWidget {
  static const String id = "homeScreen";

  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool downloading = false;
  String progressString = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();

      setState(() {
        downloading = true;
      });

      await dio.download(
        'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
        "${dir.path}/flutter_tutorial.pdf",
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progressString =
                  "${((received / total) * 100).toStringAsFixed(0)}%";
            });
          }
        },
      );

      setState(() {
        downloading = false;
        progressString = "Completed";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Download Completed! File saved to ${dir.path}/flutter_tutorial.pdf')),
      );
    } catch (e) {
      setState(() {
        downloading = false;
        progressString = "Failed";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            downloading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20.0),
                      Text(
                        'Downloading File: $progressString',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: downloadFile,
                    child: const Text('Download File'),
                  ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WebViewPage()),
                );
              },
              child: const Text('Open Webview'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: homeScreen(),
  ));
}
