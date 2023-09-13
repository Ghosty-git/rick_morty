import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';

@injectable
class UseCharacterCase {
  final CharacterRepository characterRepository;

  UseCharacterCase({required this.characterRepository});

  Future<CharacterModel> getCharacter(int page) async =>
      await characterRepository.getCharacter(page);

  Future<List<EpisoddeResult>> getCharacterEpisode(CharacterResult model) async =>
      await characterRepository.getCharacterEpisode(model);
}
