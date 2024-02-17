import 'package:assignment/weather/cubit/together_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../models/together_state_model.dart';
import '../screens/home_screen.dart';

class CardListWidget extends StatefulWidget {
  final List<TogetherStateModel> dataListItems;
  final ValueGetter<Future<void>> onRefresh;
  final TogetherStateStatus status;

  const CardListWidget({
    Key? key,
    required this.dataListItems,
    required this.onRefresh,
    required this.status,
  }) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  int fetchPageNumber = 2;

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: () =>
          context.read<TogetherCubit>().loadMoreDataList(fetchPageNumber++),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          if (index < widget.dataListItems.length) {
            return ListViewDesign(
              index: index,
              dataListItems: widget.dataListItems,
            );
          } //else if(){
          // no more data condition.
          // }
          // next pages fetch failure handling here.
          else if (widget.status == TogetherStateStatus.moreDataLoadFailure) {
            return Card(
              elevation: 0,
              color: Colors.green[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Could not load more data!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(16),
            height: 100,
            child: Card(
              elevation: 0,
              color: Colors.green[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }),
        itemCount: widget.dataListItems.length + 1,
      ),
    );
  }
}

class ListViewDesign extends StatelessWidget {
  final int index;
  final List<TogetherStateModel> dataListItems;

  const ListViewDesign({
    Key? key,
    required this.index,
    required this.dataListItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
          builder: (buildContext, boxConstraints) {
            return ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  dataListItems[index].image_url,
                ),
              ),
              title: Text(
                dataListItems[index].title,
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                dataListItems[index].description,
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class alternativeDesign extends StatelessWidget {
  const alternativeDesign({
    super.key,
    required this.dataListItems,
    required this.index,
  });

  final List<TogetherStateModel> dataListItems;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            dataListItems[index].title,
            style: TextStyle(
              color: Colors.green[400],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            dataListItems[index].description,
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
