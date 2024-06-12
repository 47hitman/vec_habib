import 'package:flutter/material.dart';
// import 'package:onmapps/screens/home/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview',
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 186, 212, 19),
                    Color.fromARGB(255, 172, 113, 37),
                  ],
                ),
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Webview"),
        ),
        body: Stack(children: <Widget>[
          WebView(
            initialUrl: "https://www.youtube.com/watch?v=lpnKWK-KEYs",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ]),
      ),
    );
  }
}
