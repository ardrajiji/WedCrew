part of 'pacakge_selection_bloc.dart';

@freezed
class PacakgeSelectionEvent with _$PacakgeSelectionEvent {
  const factory PacakgeSelectionEvent.started() = _Started;
  const factory PacakgeSelectionEvent.packageSelected() = _packageSelected;
  
  
}