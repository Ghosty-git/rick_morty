import 'package:injectable/injectable.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';
import 'package:rick_morty/features/locations/domain/repositories/location_repository.dart';

import '../../../characters/data/models/character_model.dart';

@injectable
class LocationUseCase {
  final LocationRepository locationRepository;

  LocationUseCase({required this.locationRepository});

  Future<LocationModel> getLocation() async =>
      await locationRepository.getLocation();

  Future<List<CharacterResult>> getLocationCharacter(LocationResult model) async =>
      await locationRepository.getLocationCharacter(model);
}
