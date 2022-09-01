import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/repository/book_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BookRepository repo;

  HomeBloc(this.repo) : super(const HomeState()) {
    on<FetchBooksData>((event, emit) => _fetchBooksData(event, emit));
    on<FetchMoreBooksData>((event, emit) => _fetchMoreBooksData(event, emit));
  }


  FutureOr<void> _fetchMoreBooksData(FetchMoreBooksData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final list = await repo.getBooks(page: state.page,search: event.searchText) ?? [];
    list.insertAll(0, state.bookList);
    emit(state.copyWith(isLoading: false, bookList: list, page: state.page + 1));
  }

  _fetchBooksData(FetchBooksData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, page: 0));
    final list = await repo.getBooks(page: state.page,search: event.searchText) ?? [];
    emit(state.copyWith(isLoading: false, bookList: list, page: state.page + 1));
  }
}
