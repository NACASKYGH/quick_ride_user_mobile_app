import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebview extends StatefulWidget {
  const AppWebview({
    super.key,
    this.title = '',
    required this.url,
    this.onPop,
    this.onPageStarted,
    this.onUrlChanged,
  });

  final String url;
  final String title;
  final Function()? onPop;
  final Function(String)? onPageStarted;
  final Function(BuildContext context, String url)? onUrlChanged;

  @override
  State<AppWebview> createState() => _AppWebviewState();
}

class _AppWebviewState extends State<AppWebview> {
  int progress = 0;

  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          if (mounted) setState(() => this.progress = progress);
        },
        onPageStarted: widget.onPageStarted,
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          widget.onUrlChanged?.call(context, request.url);
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.url));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: progress < 100,
              child: LinearProgressIndicator(
                value: progress / 100,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
