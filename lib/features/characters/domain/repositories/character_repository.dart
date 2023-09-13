import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';

abstract class CharacterRepository {
  Future<CharacterModel> getCharacter(int page);
  Future<List<EpisoddeResult>> getCharacterEpisode(CharacterResult model);
}
