import 'package:flutter_bloc_pagination/infrastructure/model/model.dart';

class ImageLinkModel extends Model{
  String? smallThumbnail;
  String? thumbnail;

  ImageLinkModel.fromMap(map) {
    smallThumbnail = stringFromJson(map, 'smallThumbnail');
    thumbnail = stringFromJson(map, 'thumbnail');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'smallThumbnail':smallThumbnail,
      'thumbnail':thumbnail,
    };
  }

}