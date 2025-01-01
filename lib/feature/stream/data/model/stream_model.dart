class StreamModel {
  String streamId;
  String streamName;
  String streamImage;
  String imageBeforUpload;
  String hostUserName;
  String? hostUserImage;
  String userId;
  StreamModel(
      {required this.streamId,
      required this.streamName,
      required this.streamImage,
      required this.hostUserName,
      required this.imageBeforUpload,
      this.hostUserImage,
      required this.userId});

  factory StreamModel.fromDocument(Map<String, dynamic> json) {
    return StreamModel(
      streamId: json['streamId'],
      streamName: json['streamName'],
      streamImage: json['streamImage'],
      hostUserName: json['hostUserName'],
      hostUserImage: json['hostUserImage'],
      userId: json['userId'],
      imageBeforUpload: json['imageBeforUpload'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'streamId': streamId,
      'streamName': streamName,
      'streamImage': streamImage,
      'hostUserName': hostUserName,
      'hostUserImage': hostUserImage,
      'userId': userId,
      'imageBeforUpload': imageBeforUpload
    };
  }
}
