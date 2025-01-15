class VideoModel {
  final int id;
  final bool isMine;
  final int roomId;
  final String videoUrl;
  final String previewUrl;
  final String size;
  final String duration;
  final int? likesCount; // Use int? to handle null values
  final String likesCountTranslated;
  final bool authLikeStatus;

  VideoModel({
    required this.id,
    required this.isMine,
    required this.roomId,
    required this.videoUrl,
    required this.previewUrl,
    required this.size,
    required this.duration,
    this.likesCount,
    required this.likesCountTranslated,
    required this.authLikeStatus,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      isMine: json['is_mine'],
      roomId: json['room_id'],
      videoUrl: json['video'],
      previewUrl: json['preview'],
      size: json['size'],
      duration: json['duration'],
      likesCount: json['likes_count'],
      likesCountTranslated: json['likes_count_translated'],
      authLikeStatus: json['auth_like_status'],
    );
  }
}
