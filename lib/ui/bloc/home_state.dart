import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_pagination/infrastructure/model/book.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final int page;
  final List<Book> bookList;

  const HomeState({
    this.isLoading = true,
    this.page = 0,
    this.bookList = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    int? page,
    List<Book>? bookList,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      bookList: bookList ?? this.bookList,
    );
  }

  @override
  List<Object?> get props => [isLoading, page, bookList];
}
