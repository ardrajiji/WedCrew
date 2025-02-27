import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_package_event.dart';
part 'basic_package_state.dart';
part 'basic_package_bloc.freezed.dart';

class BasicPackageBloc extends Bloc<BasicPackageEvent, BasicPackageState> {
  BasicPackageBloc() : super(_Initial()) {
    on<BasicPackageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
