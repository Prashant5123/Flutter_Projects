import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter/controller/loader.dart';
import 'package:news_app_flutter/model/news.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';





// ignore: must_be_immutable
class WebView extends StatefulWidget {
  int index;
   
  WebView({super.key,required this.index});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController _controller;
    bool _isLoading = true;



    @override
void didChangeDependencies() {
  super.didChangeDependencies();
  
  final newsUrl = Provider.of<News>(context, listen: false).newsData["articles"][widget.index]["url"];
  _controller = WebViewController()
    ..loadRequest(Uri.parse(newsUrl))
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            _isLoading = false;
          });
        },
      ),
    );
}

 

   
 

      

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: Colors.black,
          title: Text(
            "World News",
            style: GoogleFonts.sahitya(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          leading: Image.asset("assets/image.png", color: Colors.white),
        ),

      body:Stack(
        children: [
         WebViewWidget(
          controller:_controller,
        ),

        if(_isLoading)Loader.circularLoading()
        ]
      ),
    );
  }
}