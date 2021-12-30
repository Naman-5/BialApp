import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: WebResources(),
                height: MediaQuery.of(context).size.height,
              )
            ],
          ),
        ));
  }
}

class WebResources extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebResources({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://www.bengaluruairport.com/corporate/engage-with-us/airline-partners.html#AirlinePartners',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewcontroller) {
        _controller.complete(webViewcontroller);
      },
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),
    );
  }
}
