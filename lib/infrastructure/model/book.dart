import 'package:flutter_bloc_pagination/infrastructure/model/image_link.dart';
import 'package:flutter_bloc_pagination/infrastructure/model/model.dart';
import 'package:flutter_bloc_pagination/infrastructure/model/volume_info_model.dart';

class Book extends Model {
  String id = '';
  String etag = '';
  String? selfLink;
  VolumeInfoModel? volumeInfo;

  Book({required this.id, this.volumeInfo});

  Book.fromMap(Map map) {
    id = stringFromJson(map, 'id', defaultVal: '')!;
    etag = stringFromJson(map, 'etag', defaultVal: '')!;
    selfLink = stringFromJson(map, 'selfLink');
    if(map['volumeInfo'] is Map) {
      volumeInfo = VolumeInfoModel.fromMap(map['volumeInfo']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'etag': etag,
      'selfLink': selfLink,
      'volumeInfo': volumeInfo?.toJson(),
    };
  }
}
