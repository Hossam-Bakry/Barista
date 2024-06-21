import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebWidgetView extends StatefulWidget {
  const WebWidgetView({super.key});

  @override
  State<WebWidgetView> createState() => _WebWidgetViewState();
}

class _WebWidgetViewState extends State<WebWidgetView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setUserAgent(
        "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36")
    ..loadRequest(
      Uri.parse('https://mybarista.org:3001/auth/google'),
    );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.toString());
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      width: MediaQuery.of(context).size.width,
      // child: WebViewWidget(
      //   controller: controller,
      // ),
    );
  }
}
