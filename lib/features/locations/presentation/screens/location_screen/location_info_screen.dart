import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';

import '../../../../../internal/dependecies/get_it.dart';
import '../../../../../internal/helpers/utils.dart';
import '../../logic/bloc/location_bloc.dart';

class LocationInfoScreen extends StatefulWidget {
  final LocationResult locationModel;
  const LocationInfoScreen({
    super.key,
    required this.locationModel,
  });

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  late LocationBloc bloc;

  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    bloc.add(GetCharacterEvent(locationResult: widget.locationModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 383.w,
              height: 298.h,
              child: Image.asset(
                "assets/images/location.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 34.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.locationModel.name ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Мир • ${widget.locationModel.name}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  const Text(
                    "Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  const Text(
                    "Персонажи",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  BlocConsumer<LocationBloc, LocationState>(
                    bloc: bloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is LocationLoadingState) {
                        return CircularProgressIndicator();
                      }

                      if (state is LocationCharacterLoadedState) {
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.characterModelList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: 74.r,
                                    width: 74.r,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(500).r,
                                      child: Image.network(
                                        state.characterModelList[index].image
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getStatus(state
                                                .characterModelList[index]
                                                .status),
                                        style: TextStyle(
                                            color: getColor(
                                              state.characterModelList[index]
                                                  .status,
                                            ),
                                            fontSize: 10),
                                      ),
                                      Text(
                                        state.characterModelList[index].name
                                            .toString(),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "",
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${getSpecies(state.characterModelList[index].species)}",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12)),
                                            TextSpan(
                                              text:
                                                  " ${getGender(state.characterModelList[index].gender)}",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )

                                
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24.h);
                            });
                      }

                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.red,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
