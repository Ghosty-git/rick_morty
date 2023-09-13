// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class GetCharacterEvent extends CharacterEvent {
  final int page;
  final bool isFirstCall;
  GetCharacterEvent({
    required this.page,
     this.isFirstCall = false,
  });
}

class GetEpisodeEvent extends CharacterEvent {
  final CharacterResult characterResult;
  
  GetEpisodeEvent({required this.characterResult});
}
