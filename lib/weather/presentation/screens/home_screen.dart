import 'package:assignment/weather/models/together_state_model.dart';

import '../../cubit/together_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/error_screen_widget.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/card_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initialDataFetch = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies

    if (initialDataFetch == 0) {
      context.read<TogetherCubit>().fetchDataList(1);
      initialDataFetch = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Together Funds',
        ),
      ),
      body: Center(
        child: BlocBuilder<TogetherCubit, TogetherCubitState>(
          // to call change theme in ThemeCubit. and reflect in MaterialApp theme.

          builder: (context, state) {
            // print('############   REBUILDING MAIN SCREEN   #############\n\n');
            // print(
            //     '############   ${state.stateListItems.length}   #############\n\n');
            switch (state.status) {
              case TogetherStateStatus.loading:
                return const LoadingScreen();
              case TogetherStateStatus.success ||
                    TogetherStateStatus.moreDataLoading ||
                    TogetherStateStatus.moreDataLoadFailure:
                return CardListWidget(
                  dataListItems: state.stateListItems,
                  onRefresh: () {
                    return context.read<TogetherCubit>().fetchDataList(1);
                  },
                  status: state.status,
                );
              case TogetherStateStatus.failure:
                return const ErrorScreen();
            }
          },
        ),
      ),
    );
  }
}
