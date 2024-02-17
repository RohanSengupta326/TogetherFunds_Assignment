// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'together_cubit.dart';

enum TogetherStateStatus {
  loading,
  moreDataLoading,
  success,
  failure,
  moreDataLoadFailure
}

extension TogetherStateStatusX on TogetherStateStatus {
  bool get isLoading => this == TogetherStateStatus.loading;
  bool get isMoreDataLoading => this == TogetherStateStatus.moreDataLoading;
  bool get isSuccess => this == TogetherStateStatus.success;
  bool get isFailure => this == TogetherStateStatus.failure;
  bool get nextPageFetchFailure =>
      this == TogetherStateStatus.moreDataLoadFailure;
}

@immutable
class TogetherCubitState extends Equatable {
  final TogetherStateStatus status;
  final List<TogetherStateModel> stateListItems;
  TogetherCubitState({
    this.status = TogetherStateStatus.loading,
    this.stateListItems = const [],
  });

  TogetherCubitState copyWith({
    TogetherStateStatus? status,
    List<TogetherStateModel>? stateListItems,
  }) {
    return TogetherCubitState(
      status: status ?? this.status,
      stateListItems: stateListItems ?? this.stateListItems,
    );
  }

  @override
  List<Object?> get props => [status, stateListItems];
}
