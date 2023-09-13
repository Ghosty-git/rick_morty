// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';
import 'package:rick_morty/features/locations/domain/use_cases/location_use_case.dart';
import 'package:rick_morty/internal/helpers/catch_exception.dart';

part 'location_event.dart';
part 'location_state.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationUseCase useCase;
  LocationBloc(this.useCase) : super(LocationInitial()) {
    on<GetLocationEvent>(
      (event, emit) async {
        emit(LocationLoadingState());
        await useCase
            .getLocation()
            .then(
              (locationModel) => emit(
                LocationLoadedState(locationModel: locationModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                LocationErrorState(
                  error: CatchException.convertException(error),
                ),
              ),
            );
      },
    );

    on<GetCharacterEvent>(
      (event, emit) async {
        emit(LocationLoadingState());

        await useCase
            .getLocationCharacter(event.locationResult)
            .then(
              (characterModel) => emit(
                LocationCharacterLoadedState(
                    characterModelList: characterModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(
                LocationErrorState(
                    error: CatchException.convertException(error)),
              ),
            );
      },
    );
  }
}
