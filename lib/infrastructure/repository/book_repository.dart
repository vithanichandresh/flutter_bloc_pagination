import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_pagination/infrastructure/utils/api.dart';
import 'package:http/http.dart';

import '../model/book.dart';

class BookRepository {
  Future<List<Book>?> getBooks({String? search, int page = 0}) async {
    try {
      String url = '${Api.baseUrl}/volumes?q=$search&startIndex=$page';
      print(url);
      final result = await get(Uri.parse(url));
      Map map = jsonDecode(result.body);
      List list = map['items'];
      return list.map((e) => Book.fromMap(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
