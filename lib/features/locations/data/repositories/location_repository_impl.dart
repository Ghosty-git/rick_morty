import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';
import 'package:rick_morty/features/locations/domain/repositories/location_repository.dart';
import 'package:rick_morty/internal/helpers/api_requester.dart';

import '../../../../internal/helpers/catch_exception.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository{
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<LocationModel> getLocation() async {

       try {
      Response response = await apiRequester.toGet("location", param:{});
      log("location res === ${response.data}");

      if (response.statusCode == 200) {
        return LocationModel.fromJson(response.data);
      }

      throw CharacterModel.convertException(response);
    } catch (e) {
      throw CharacterModel.convertException(e);
    }
  }
  
  @override
  Future<List<CharacterResult>> getLocationCharacter(LocationResult model) async {
    try {
      List<CharacterResult> characterModelList = [];

      for (var element in model.residents!) {
        Response response =
            await apiRequester.toGet('character/${element.substring(42)}');
          print("${element.substring(42)}");
        characterModelList.add(CharacterResult.fromJson(response.data));

      }
      
      return characterModelList;
    } catch (e) {
      print('error === $e');
      throw CatchException.convertException(e);
    }
    }
}