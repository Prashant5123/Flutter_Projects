// import 'package:flutter/material.dart';
// import 'package:news_app_flutter/view/splash_screen.dart';
// import 'package:news_app_flutter/view/web_view.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class NewsContent extends StatefulWidget {
//   int index;

//   NewsContent({super.key, required this.index});

//   @override
//   State<NewsContent> createState() => _NewsContentState();
// }

// class _NewsContentState extends State<NewsContent> {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 30,
//         backgroundColor: const Color.fromARGB(255, 180, 224, 255),
//         automaticallyImplyLeading: false,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     '"${newsData["articles"][widget.index]["title"]}"',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       (newsData["articles"][widget.index]["urlToImage"] != null)
//                           ? true
//                           : false,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//                       height: 200,
//                       width: MediaQuery.of(context).size.width,
//                       clipBehavior: Clip.antiAlias,
//                       decoration:
//                           BoxDecoration(borderRadius: BorderRadius.circular(8)),
//                       child: Image.network(
//                         newsData["articles"][widget.index]["urlToImage"]
//                             .toString(),
//                         fit: BoxFit.cover,
//                         filterQuality: FilterQuality.high,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             color: Colors.grey[200],
//                             child: Icon(
//                               Icons.broken_image,
//                               color: Colors.grey,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: 150,
//                         child: Text(
//                           " Author: ${newsData["articles"][widget.index]["author"]}",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Container(
//                         width: 150,
//                         child: Text(
//                           " Date: ${newsData["articles"][widget.index]["publishedAt"]}",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Text(
//                     "${newsData["articles"][widget.index]["description"]}",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
                
//                 GestureDetector(
//                   onTap: () {
                
                    
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => WebView(index: widget.index)));

                    
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.lightBlue),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         "View Full Article",
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
