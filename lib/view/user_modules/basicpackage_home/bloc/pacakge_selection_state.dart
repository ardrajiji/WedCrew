part of 'pacakge_selection_bloc.dart';

@freezed
class PacakgeSelectionState with _$PacakgeSelectionState {
  const factory PacakgeSelectionState.initial() = _Initial;
  const factory PacakgeSelectionState.loading() = _loading;
  const factory PacakgeSelectionState.success(List<UserPackageSelectionModel> packages) = _success;
  const factory PacakgeSelectionState.failure(String errorMessage) = _failure;
  
  
}
