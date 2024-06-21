import 'dart:convert';

import 'package:barista/featuers/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class InAppWebViewWidget extends StatefulWidget {
  const InAppWebViewWidget({super.key});

  @override
  State<InAppWebViewWidget> createState() => _InAppWebViewWidgetState();
}

class _InAppWebViewWidgetState extends State<InAppWebViewWidget> {
  final settings = InAppWebViewSettings(
    javaScriptEnabled: true,
    userAgent: "random",
    clearCache: true,
    domStorageEnabled: true,
    databaseEnabled: true,
  );

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(
          "https://mybarista.org:3001/auth/google",
        ),
      ),
      initialSettings: settings,
      onWebViewCreated: (InAppWebViewController controller) {},
      onLoadStart: (InAppWebViewController controller, Uri? url) {},
      onLoadStop: (InAppWebViewController controller, Uri? url) async {
        if (url?.toString().startsWith(
                "https://mybarista.org:3001/auth/google/callback") ??
            false) {
          // or using javascript to get access_token from localStorage
          String? tokenFromJSEvaluation = await controller
              .evaluateJavascript(source: "window.document.body.innerText;")
              .then((value) {
            print(value);
            return value;
          });
          Navigator.pop(context);
          print(jsonDecode(tokenFromJSEvaluation ?? "")["data"]["token"]);
          Provider.of<AuthProvider>(context, listen: false).setToken(
              jsonDecode(tokenFromJSEvaluation ?? "")["data"]["token"]);

          controller.clearHistory();
        }
      },
    );
  }
}
