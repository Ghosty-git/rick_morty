import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/characters/presentation/widgets/custom_textField.dart';
import 'package:rick_morty/features/locations/data/models/location_model.dart';
import 'package:rick_morty/features/locations/presentation/logic/bloc/location_bloc.dart';
import 'package:rick_morty/features/locations/presentation/screens/location_screen/location_info_screen.dart';

import '../../../../../internal/dependecies/get_it.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationBloc bloc;
  late final LocationModel locationModel;

  @override
  void initState() {
    bloc = getIt<LocationBloc>();
    bloc.add(GetLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LocationLoadedState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 54.h),
                  SizedBox(
                    height: 43.h,
                    child: const CustomTextField(
                      labelText: 'Найти локацию',
                      filterIcon: false,
                      divider: false,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ВСЕГО ДОКАЦИЙ: ${state.locationModel.info!.count}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.locationModel.results!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                           onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LocationInfoScreen(locationModel: state.locationModel.results![index],),
                                    ),
                                  );
                                },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 150.h,
                                      width: 343.w,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.asset(
                                          "assets/images/location.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(bottom: 12.h, left: 16.w, right: 16.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            state.locationModel.results![index]
                                                    .name ??
                                                "",
                                                textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            "Мир • ${state.locationModel.results![index].name ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 24.h,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
