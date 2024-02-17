import '/repository/models/together_repository_model.dart';
import 'package:bloc/bloc.dart';
import '../../repository/together_repository.dart';
import '../models/together_state_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'together_cubit_state.dart';

class TogetherCubit extends Cubit<TogetherCubitState> {
  TogetherCubit({required this.togetherRepository})
      : super(TogetherCubitState());
  final TogetherRepository togetherRepository;

  List<TogetherStateModel> localDataListItems = [];

  Future<void> fetchDataList(int fetchPageNumber) async {
    emit(
      state.copyWith(status: TogetherStateStatus.loading),
    );

    try {
      final fetchedDataList =
          await togetherRepository.fetchApiClientList(fetchPageNumber);
      for (var i = 0; i < fetchedDataList.apiRepositoryListItem.length; i++) {
        final fetchedDataListItems = fetchedDataList.apiRepositoryListItem[i];

        localDataListItems.add(
          TogetherStateModel(
            id: fetchedDataListItems.id,
            title: fetchedDataListItems.title,
            description: fetchedDataListItems.description,
            image_url: fetchedDataListItems.image_url,
          ),
        );
      }

      emit(
        state.copyWith(
          status: TogetherStateStatus.success,
          stateListItems: localDataListItems,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: TogetherStateStatus.failure));
    }
  }

  Future<void> loadMoreDataList(int nextPageNumber) async {
    emit(
      state.copyWith(
        status: TogetherStateStatus.moreDataLoading,
      ),
    );

    try {
      final fetchedDataList =
          await togetherRepository.fetchApiClientList(nextPageNumber);
      for (var i = 0; i < fetchedDataList.apiRepositoryListItem.length; i++) {
        final fetchedDataListItems = fetchedDataList.apiRepositoryListItem[i];

        localDataListItems.add(
          TogetherStateModel(
            id: fetchedDataListItems.id,
            title: fetchedDataListItems.title,
            description: fetchedDataListItems.description,
            image_url: fetchedDataListItems.image_url,
          ),
        );
      }

      // print('############   ${localDataListItems.length}   #############\n\n');
      emit(
        state.copyWith(
          status: TogetherStateStatus.success,
          stateListItems: localDataListItems,
        ),
      );
    } catch (error) {
      // print('############   Error in loading more data   #############\n\n');
      // print('############   $error   #############\n\n');
      emit(
        state.copyWith(
          status: TogetherStateStatus.moreDataLoadFailure,
        ),
      );
    }
  }
}
