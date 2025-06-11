import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task/VideoFeedModel.dart';
import 'package:task/VideoReplyModel.dart';

class ApiService {
  static const baseUrl = 'https://api.wemotions.app';

  static Future<List<VideoFeed>> fetchFeeds(int page) async {
    final response = await http.get(
      Uri.parse('https://api.wemotions.app/feed?page=$page'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);

      // ✅ Fix: access the 'data' list from inside the map
      // log("message")l
      final List<dynamic> dataList = jsonMap['posts'];
      log("$dataList");

      return dataList.map((json) => VideoFeed.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feeds');
    }
  }

  static Future<List<VideoReply>> fetchReplies(String postId) async {
    final response = await http.get(
      Uri.parse('https://api.wemotions.app/posts/$postId/replies'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> dataList = jsonMap['post'];

      return dataList.map((json) => VideoReply.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load replies');
    }
  }
}
