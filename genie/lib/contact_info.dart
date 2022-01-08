import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genie/common_variables.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AirlineContact extends StatelessWidget {
  const AirlineContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[300],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
          ),
        ),
        body: _ButtonGrid());
  }
}

class _ButtonGrid extends StatelessWidget {
  final _airlineData = airlineDetails;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => _AirlineDetail(
          _airlineData[index]['Title'].toString(),
          _airlineData[index]['LogoPath'].toString(),
          _airlineData[index]['Website']),
      itemCount: _airlineData.length,
    );
  }
}

// ignore: must_be_immutable
class _AirlineDetail extends StatelessWidget {
  String title = "";
  String path = "";
  String? website = "";
  _AirlineDetail(this.title, this.path, this.website);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: SizedBox(
            child: Image(
              image: NetworkImage(path),
              fit: BoxFit.cover,
            ),
            height: 100,
            width: 165,
          )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            _AirlineWebsite(website.toString())));
              },
              child: Text(
                title,
                style: const TextStyle(color: Colors.indigo),
              ))
        ],
      ),
    );
  }
}

class _AirlineWebsite extends StatelessWidget {
  String website = "";
  late WebViewController _controller;
  _AirlineWebsite(this.website);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: website,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewcontroller) {
          _controller = webViewcontroller;
        },
      ),
    );
  }
}
