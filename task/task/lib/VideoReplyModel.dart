class VideoReply {
  final String id;
  final String videoUrl;

  VideoReply({required this.id, required this.videoUrl});

  factory VideoReply.fromJson(Map<String, dynamic> json) {
    return VideoReply(
      id: json['id'].toString(),
      videoUrl: json['video_link'] ?? '',
    );
  }
}
