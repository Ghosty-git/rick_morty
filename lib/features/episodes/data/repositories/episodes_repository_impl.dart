


import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';
import 'package:rick_morty/internal/helpers/api_requester.dart';

import '../../domain/repositories/episde_repository.dart';

@Injectable(as: EpisodeRepository)
class EpisodeRepositoryImpl implements  EpisodeRepository{
  ApiRequester apiRequester = ApiRequester();
  @override
   
  Future<EpisodeModel> getEpisode() async {

       try {
      Response response = await apiRequester.toGet("episode", param:{});
      log("user response === ${response.data}");

      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      }

      throw EpisodeModel.convertException(response);
    } catch (e) {
      throw EpisodeModel.convertException(e);
    }
  }
}