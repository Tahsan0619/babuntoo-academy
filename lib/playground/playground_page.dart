import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlaygroundPage extends StatefulWidget {
  final String language; // Use 'C' or 'Python'
  const PlaygroundPage({Key? key, this.language = 'C'}) : super(key: key);

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final String url = widget.language == 'C'
        ? 'https://www.programiz.com/c-programming/online-compiler/'
        : 'https://www.programiz.com/python-programming/online-compiler/';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Playground')),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
