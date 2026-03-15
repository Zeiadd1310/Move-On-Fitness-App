import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  WebViewController? _controller;
  bool _isInitialized = false;

  static const String _html = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { 
      width: 100%; 
      height: 100%; 
      overflow: hidden;
    }
    zapier-interfaces-chatbot-embed {
      display: block;
      width: 100%;
      height: 100vh;
      min-height: 100%;
    }
  </style>
</head>
<body>
  <script async type="module"
    src="https://interfaces.zapier.com/assets/web-components/zapier-interfaces/zapier-interfaces.esm.js">
  </script>
  <zapier-interfaces-chatbot-embed
    is-popup="false"
    chatbot-id="cmmnrhx73004ubbdn9jqhwfow">
  </zapier-interfaces-chatbot-embed>
</body>
</html>
''';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initWebView());
  }

  Future<void> _initWebView() async {
    if (_isInitialized) return;
    _isInitialized = true;

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_html, baseUrl: 'https://interfaces.zapier.com');

    if (!mounted) return;
    setState(() => _controller = controller);
  }

  @override
  void dispose() {
    _controller = null;
    _isInitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return WebViewWidget(controller: _controller!);
  }
}
