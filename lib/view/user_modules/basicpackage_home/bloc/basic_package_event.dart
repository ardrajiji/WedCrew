part of 'basic_package_bloc.dart';

@freezed
class BasicPackageEvent with _$BasicPackageEvent {
  const factory BasicPackageEvent.started() = _Started;
  
}