class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  static List<Album> listToAlbums(List jsonList) {
    return jsonList.map((e) => Album.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Album{userId: $userId, id: $id, title: $title}';
  }
}
// class Album {
//   String tags;
//   String previewURL;
//
//   Album({
//     required this.tags,
//     required this.previewURL,
//   });
//
//   factory Album.fromJson(Map<String,dynamic> json){
//     return Album(
//       tags: json['tags'],
//       previewURL: json['previewURL']
//     );
//   }
//
//   static List<Album> listToAlbums(List jsonList) {
//     return jsonList.map((e) => Album.fromJson(e)).toList();
//   }
//
//   @override
//   String toString() {
//     return 'Album{tags: $tags, previewURL: $previewURL}';
//   }
// }
