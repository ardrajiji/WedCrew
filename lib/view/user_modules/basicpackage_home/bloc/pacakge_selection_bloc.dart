import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wed_crew/view/user_modules/basicpackage_home/model/user_package_selection_model.dart';

part 'pacakge_selection_event.dart';
part 'pacakge_selection_state.dart';
part 'pacakge_selection_bloc.freezed.dart';

class PacakgeSelectionBloc extends Bloc<PacakgeSelectionEvent, PacakgeSelectionState> {
  PacakgeSelectionBloc() : super(_Initial()) {
    on<PacakgeSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
