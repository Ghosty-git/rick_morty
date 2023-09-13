import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';
import 'package:rick_morty/features/episodes/domain/use_cases/episode_use_cases.dart';

import '../../../../../internal/helpers/catch_exception.dart';

part 'episode_event.dart';
part 'episode_state.dart';

@injectable
class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final UseEpisodeCase useCase;
  EpisodeBloc(this.useCase) : super(EpisodeInitial()) {
    on<EpisodeEvent>((event, emit) {});

    on<GetEpisodeEvent>(
      (event, emit) async {
        emit(EpisodeLoadingState());
        await useCase
            .getEpisode()
            .then(
              (episodeModel) => emit(
                EpisodeLoadedState(episodeModel: episodeModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                EpisodeErrorState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );
  }
}
