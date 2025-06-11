import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/VideoFeedModel.dart';
import 'package:task/VideoReplyModel.dart';

import 'api_service.dart';
import 'video_player_widget.dart';

class VideoFeedScreen extends StatefulWidget {
  @override
  _VideoFeedScreenState createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  int _page = 1;
  List<VideoFeed> _feeds = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  Map<String, List<VideoReply>> _replies = {};
  Set<String> _expandedPosts = {};

  @override
  void initState() {
    super.initState();
    _loadFeeds();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _loadFeeds();
      }
    });
  }

  Future<void> _loadFeeds() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      List<VideoFeed> feeds = await ApiService.fetchFeeds(_page);
      setState(() {
        _feeds.addAll(feeds);
        _page++;
      });
    } catch (e) {
      print("Error loading feeds: $e");
    }
    setState(() => _isLoading = false);
  }

  Future<void> _loadReplies(String postId) async {
    if (_replies.containsKey(postId)) return;
    try {
      List<VideoReply> replies = await ApiService.fetchReplies(postId);
      setState(() => _replies[postId] = replies);
    } catch (e) {
      print("Error loading replies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Feed")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _feeds.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index1) {
          // if (index1 == _feeds.length)
          //   return Center(child: CircularProgressIndicator());




          final feed = _feeds[index1];
          final isExpanded = _expandedPosts.contains(feed.id);

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:_replies.length ,
            itemBuilder: (context,index2){
            log("${_replies["post"]![index2].videoUrl}");
            return Container(
              
              child:  CustomVideoPlayer(videoUrl:_replies["post"]![index2].videoUrl,)
            );
          });

          
          

          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CustomVideoPlayer(videoUrl: feed.videoUrl),
          //     ListTile(
          //       title: Text(feed.title),
          //       trailing: IconButton(
          //         icon: Icon(
          //           isExpanded ? Icons.expand_less : Icons.expand_more,
          //         ),
          //         onPressed: () async {
          //           if (!isExpanded) await _loadReplies(feed.id);
          //           setState(() {
          //             isExpanded
          //                 ? _expandedPosts.remove(feed.id)
          //                 : _expandedPosts.add(feed.id);
          //           });
          //         },
          //       ),
          //     ),
          //     if (isExpanded)
          //       _replies[feed.id] == null
          //           ? Center(child: CircularProgressIndicator())
          //           : _replies[feed.id]!.isEmpty
          //           ? Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text("No replies available."),
          //           )
          //           : SizedBox(
          //             height: 180,
          //             child: ListView.builder(
          //               scrollDirection: Axis.horizontal,
          //               itemCount: _replies[feed.id]!.length,
          //               itemBuilder: (context, replyIndex) {
          //                 return Container(
          //                   width: 150,
          //                   margin: EdgeInsets.all(8),
          //                   child: CustomVideoPlayer(
          //                     videoUrl: _replies[feed.id]![replyIndex].videoUrl,
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //   ],
          // );
        },
      ),
    );
  }
}
