import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AirlineContact extends StatelessWidget {
  const AirlineContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
  final _airlineData = [
    {
      'Title': 'Vistara',
      'LogoPath':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/vistara.png',
      'Website': 'https://www.airvistara.com/in/en'
    },
    {
      'Title': 'Air-India',
      'LogoPath':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/air-india-logo.png',
      'Website': 'https://www.airindia.in/index.htm'
    },
    {
      'Title': 'Indigo',
      'LogoPath':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/indigo.png',
      'Website': 'https://www.goindigo.in/'
    },
    {
      'Title': 'Spice-Jet',
      'LogoPath':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/spice.jpeg',
      'Website': 'https://www.spicejet.com/'
    },
    {
      'Title': 'Trujet',
      'LogoPath':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/trujet.jpeg',
      'Website': 'https://www.trujet.com/#/home'
    }
  ];
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
              child: Image(
            image: NetworkImage(path),
            fit: BoxFit.cover,
          )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            _AirlineWebsite(website.toString())));
              },
              child: Text(title))
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
