import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';
import 'package:rick_morty/internal/helpers/api_requester.dart';
import 'package:rick_morty/internal/helpers/catch_exception.dart';

@Injectable(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  ApiRequester apiRequester = ApiRequester();
  @override
  Future<CharacterModel> getCharacter(int page) async {
    try {
      Response response = await apiRequester.toGet(
        "character",
        param: {'page': page},
      );
      
      log("user response === ${response.data}");

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      }

      throw CharacterModel.convertException(response);
    } catch (e) {
      throw CharacterModel.convertException(e);
    }
  }

  @override
  Future<List<EpisoddeResult>> getCharacterEpisode(
      CharacterResult model) async {
    try {
      List<EpisoddeResult> episodeModelList = [];

      for (var element in model.episode!) {
        Response response =
            await apiRequester.toGet('episode/${element.substring(40)}');

        episodeModelList.add(EpisoddeResult.fromJson(response.data));

        print(episodeModelList);
      }

      return episodeModelList;
    } catch (e) {
      print('error === $e');
      throw CatchException.convertException(e);
    }
  }
}
