import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBooksData extends HomeEvent {
  final String? searchText;
  const FetchBooksData([this.searchText]);

  @override
  List<Object?> get props => [searchText];
}

class FetchMoreBooksData extends HomeEvent {
  final String? searchText;
  const FetchMoreBooksData({this.searchText});

  @override
  List<Object?> get props => [searchText];
}