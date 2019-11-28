import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  WebViewPage(this.url);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  String _title = "加载中...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: WebView(
        initialUrl: widget.url,
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          _controller.evaluateJavascript("document.title").then((result) {
            setState(() {
              _title = result.replaceAll('"', "");
            });
          });
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("myapp://")) {
            print("即将打开 ${request.url}");

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
              name: "share",
              onMessageReceived: (JavascriptMessage message) {
                print("参数： ${message.message}");
              }),
        ].toSet(),
      ),
    );
  }
}
