import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pagination/infrastructure/model/book.dart';
import 'package:flutter_bloc_pagination/ui/bloc/home_bloc.dart';
import 'package:flutter_bloc_pagination/ui/bloc/home_event.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  var textEditController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: textEditController,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (val) {
            if (val.replaceAll(' ', '').isNotEmpty) {
              context.read<HomeBloc>().add(FetchBooksData(val));
            }
          },
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.isLoading != current.isLoading || previous.bookList != current.bookList,
        listener: (context, state) {
          if (!state.isLoading) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          return SmartRefresher(
            enablePullUp: true,
            header: const WaterDropMaterialHeader(),
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                switch (mode) {
                  case LoadStatus.idle:
                    body = const Text('Pull up to load more');
                    break;
                  case LoadStatus.loading:
                    body = const CircularProgressIndicator();
                    break;
                  case LoadStatus.failed:
                    body = const Text('Load Failed! Click retry!');
                    break;
                  default:
                    body = const Text('No more matches');
                    break;
                }
                return SizedBox(
                  height: 55,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: () {
              HapticFeedback.lightImpact();
              context.read<HomeBloc>().add(const FetchBooksData());
            },
            onLoading: () {
              HapticFeedback.lightImpact();
              String? val;
              if (textEditController.text.replaceAll(' ', '').isNotEmpty) {
                val = textEditController.text;
              }
              context.read<HomeBloc>().add(FetchMoreBooksData(searchText: val));
            },
            child: ListView.separated(
              itemCount: state.bookList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                Book book = state.bookList.elementAt(index);
                return ListTile(
                  leading: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(
                        book.volumeInfo!.imageLinks?.thumbnail ?? '',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      )),
                  title: Text(book.volumeInfo!.title ?? ''),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        book.volumeInfo!.subtitle ?? (book.volumeInfo!.description ?? ''),
                        maxLines: 4,
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
