import 'package:flutter_bloc_pagination/infrastructure/model/model.dart';

import 'image_link.dart';

class VolumeInfoModel extends Model {
  String? title;
  String? subtitle;
  String? description;
  String? publisher;

  DateTime? publishedDate;
  List authors = [];
  int pageCount = 0;

  double averageRating = 0;
  int ratingsCount = 0;
  ImageLinkModel? imageLinks;

  VolumeInfoModel.fromMap(Map map) {
    title = stringFromJson(map, 'title');
    subtitle = stringFromJson(map, 'subtitle');
    description = stringFromJson(map, 'description');
    publisher = stringFromJson(map, 'publisher');
    publishedDate = dateFromJson(map, 'publishedDate');
    authors = listFromJson(map, 'authors');
    pageCount = intFromJson(map, 'pageCount', defaultVal: 0)!;
    averageRating = doubleFromJson(map, 'averageRating', defaultVal: 0)!;
    ratingsCount = intFromJson(map, 'ratingsCount', defaultVal: 0)!;
    if(map['imageLinks'] is Map) {
      imageLinks = ImageLinkModel.fromMap(map['imageLinks']);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'publisher': publisher,
      'publishedDate': publishedDate.toString(),
      'authors': authors,
      'pageCount': pageCount,
      'averageRating': averageRating,
      'ratingsCount': ratingsCount,
    };
  }
}
