
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';

abstract class LocationRepository {
  Future<LocationModel> getLocation();
  
  Future<List<CharacterResult>> getLocationCharacter(LocationResult model);
}

