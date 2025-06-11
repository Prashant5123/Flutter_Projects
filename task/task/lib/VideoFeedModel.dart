class VideoFeed {
  final String id;
  final String videoUrl;
  final String title;

  VideoFeed({required this.id, required this.videoUrl, required this.title});

  factory VideoFeed.fromJson(Map<String, dynamic> json) {
    return VideoFeed(
      id: json['id'].toString(),
      videoUrl: json['video_link'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
