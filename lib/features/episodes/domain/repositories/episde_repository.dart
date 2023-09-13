

import 'package:rick_morty/features/episodes/data/models/episode_model.dart';

abstract class EpisodeRepository {
  Future<EpisodeModel> getEpisode();
}