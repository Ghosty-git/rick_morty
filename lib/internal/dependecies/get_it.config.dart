// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/characters/data/repositories/characters_repository_impl.dart'
    as _i4;
import '../../features/characters/domain/repositories/character_repository.dart'
    as _i3;
import '../../features/characters/domain/use_cases/character_use_cases.dart'
    as _i10;
import '../../features/characters/presentation/logic/bloc/character_bloc.dart'
    as _i12;
import '../../features/episodes/data/repositories/episodes_repository_impl.dart'
    as _i6;
import '../../features/episodes/domain/repositories/episde_repository.dart'
    as _i5;
import '../../features/episodes/domain/use_cases/episode_use_cases.dart'
    as _i11;
import '../../features/episodes/presentation/logic/bloc/episode_bloc.dart'
    as _i13;
import '../../features/locations/data/repositories/location_repository_impl.dart'
    as _i8;
import '../../features/locations/domain/repositories/location_repository.dart'
    as _i7;
import '../../features/locations/domain/use_cases/location_use_case.dart'
    as _i9;
import '../../features/locations/presentation/logic/bloc/location_bloc.dart'
    as _i14;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.CharacterRepository>(() => _i4.CharacterRepositoryImpl());
  gh.factory<_i5.EpisodeRepository>(() => _i6.EpisodeRepositoryImpl());
  gh.factory<_i7.LocationRepository>(() => _i8.LocationRepositoryImpl());
  gh.factory<_i9.LocationUseCase>(() =>
      _i9.LocationUseCase(locationRepository: gh<_i7.LocationRepository>()));
  gh.factory<_i10.UseCharacterCase>(() => _i10.UseCharacterCase(
      characterRepository: gh<_i3.CharacterRepository>()));
  gh.factory<_i11.UseEpisodeCase>(() =>
      _i11.UseEpisodeCase(episodeRepository: gh<_i5.EpisodeRepository>()));
  gh.factory<_i12.CharacterBloc>(
      () => _i12.CharacterBloc(gh<_i10.UseCharacterCase>()));
  gh.factory<_i13.EpisodeBloc>(
      () => _i13.EpisodeBloc(gh<_i11.UseEpisodeCase>()));
  gh.factory<_i14.LocationBloc>(
      () => _i14.LocationBloc(gh<_i9.LocationUseCase>()));
  return getIt;
}
