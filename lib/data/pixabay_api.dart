import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search_rewind/data/photo_api.dart';
import 'package:image_search_rewind/model/picture_result.dart';

class PixabayApi extends PhotoApi {
  // Future<List<Album>> fetchAlbums(String keyword) async {
  //   final response = await http.get(Uri.parse(
  //       'https://pixabay.com/api/?key=24806198-1f9550a3fd92fcce8b0067dc7&q=$keyword&image_type=photo&pretty=true'));
  //   print('response 확인 : ${response.body}');
  //
  //   if (response.statusCode == 200) {
  //     final List<Album> myFutureAlbums =
  //         Album.listToAlbums(jsonDecode(response.body)['hits']);
  //     print('jsonDecode 확인 : ${myFutureAlbums.toString()}');
  //     return myFutureAlbums;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  Future<List<Picture>> fetchPhotos(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=24806198-1f9550a3fd92fcce8b0067dc7&q=$query&image_type=photo&pretty=true'));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['hits'];
      return jsonList.map((e) => Picture.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
