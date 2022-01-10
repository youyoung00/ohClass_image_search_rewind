import 'package:image_search_rewind/model/picture_result.dart';

abstract class PhotoApi {
  Future<List<Picture>> fetchPhotos(String query);
}
