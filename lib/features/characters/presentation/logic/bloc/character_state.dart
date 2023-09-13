// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'character_bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoadedState extends CharacterState {
  final CharacterModel characterModel;

  CharacterLoadedState({required this.characterModel});
}

class CharacterLoadingState extends CharacterState {}

class CharacterErrorState extends CharacterState {
  final CatchException error;

  CharacterErrorState({required this.error});
}

class CharacterEpisodeLoadedState extends CharacterState {
  final List<EpisoddeResult> episodeModelList;

  CharacterEpisodeLoadedState({required this.episodeModelList});
}
