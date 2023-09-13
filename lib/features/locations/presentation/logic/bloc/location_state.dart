// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final LocationModel locationModel;

  LocationLoadedState({required this.locationModel});
}

class LocationErrorState extends LocationState {
  final CatchException error;

  LocationErrorState({required this.error});
}


class LocationCharacterLoadedState extends LocationState {
  final List<CharacterResult> characterModelList;

  LocationCharacterLoadedState({required this.characterModelList});
}
