   import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/episodes/data/models/episode_model.dart';

import '../../../../internal/dependecies/get_it.dart';
import '../../../characters/presentation/widgets/custom_textField.dart';
import '../logic/bloc/episode_bloc.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  late EpisodeBloc bloc;
  late final EpisodeModel episodeModel;

  @override
  void initState(){
    bloc = getIt<EpisodeBloc>();
    bloc.add(GetEpisodeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: BlocConsumer<EpisodeBloc, EpisodeState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {

        if( state is EpisodeLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state is EpisodeLoadedState){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(children: [
                 SizedBox(height: 54.h),
                  SizedBox(
                    height: 43.h,
                    // width: 343.w,
                    child: const CustomTextField(
                      labelText: 'Найти персонажа',
                      filterIcon: false,
                      divider: false,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                            bloc.add(GetEpisodeEvent());

                      },
                      child: ListView.separated(
                              itemCount: state.episodeModel.results!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                              "assets/images/image_1.png"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Серия ${state.episodeModel.results![index].id ?? 0}",
                                                style: TextStyle(
                                                    color: Color(0xff22A2BD),
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 179.w,
                                                child: Text(
                                                  "${state.episodeModel.results![index].name}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Text(
                                                "${state.episodeModel.results![index].airDate}",
                                                style: TextStyle(
                                                    color: Color(0xff6E798C),
                                                    fontSize: 14),
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
                                return SizedBox(
                                  height: 24.h,
                                );
                              },
                            ),
                    ),
                  ),
            ],),
          );
        }

        return Container(
          width: 50,
          height: 50,
          color: Colors.red,
        );
      },
    ),
    );
  }
}