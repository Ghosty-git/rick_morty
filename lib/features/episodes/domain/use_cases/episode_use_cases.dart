// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';
import '../repositories/episde_repository.dart';

@injectable
class UseEpisodeCase {
  final EpisodeRepository episodeRepository;

  UseEpisodeCase({required this.episodeRepository});

  Future<EpisodeModel> getEpisode() async => 
  await episodeRepository.getEpisode();
}
