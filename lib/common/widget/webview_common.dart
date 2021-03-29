import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String pathName;
  WebViewPage(this.url, this.pathName);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  String url = "";
  double progress = 0;
  PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  String _title = "加载中...";

  gotoHomePage() async {
    if (widget.pathName == null) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).pushReplacementNamed(widget.pathName);
    }
  }

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
            gotoHomePage();
          },
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          gotoHomePage();
        },
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: options,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url;
            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunch(url)) {
                // Launch the App
                await launch(
                  url,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
              controller.getTitle().then((value) {
                this._title = value;
              });
            });
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController.endRefreshing();
            }
            setState(() {
              this.progress = progress / 100;
              urlController.text = this.url;
            });
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
        ),
      ),
    );
  }
}
