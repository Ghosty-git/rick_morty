import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/characters/domain/use_cases/character_use_cases.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';
import 'package:rick_morty/internal/helpers/catch_exception.dart';

part 'character_event.dart';
part 'character_state.dart';

@injectable
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final UseCharacterCase useCase;
  CharacterBloc(this.useCase) : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {});

    on<GetCharacterEvent>(
      (event, emit) async {
        if(event.isFirstCall){

        emit(CharacterLoadingState());
        }

        await useCase
            .getCharacter(event.page)
            .then(
              (characterModel) => emit(
                CharacterLoadedState(characterModel: characterModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                CharacterErrorState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );

        on<GetEpisodeEvent>(
      (event, emit) async {
        emit(CharacterLoadingState());

        await useCase
            .getCharacterEpisode(event.characterResult)
            .then(
              (characterModel) => emit(
                CharacterEpisodeLoadedState(episodeModelList: characterModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                CharacterErrorState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );
  }
}
