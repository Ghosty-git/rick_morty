import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/internal/dependecies/get_it.dart';
import 'package:rick_morty/internal/helpers/utils.dart';

import '../../logic/bloc/character_bloc.dart';

class CharacterInfo extends StatefulWidget {
  final CharacterResult characterModel;

  const CharacterInfo({
    super.key,
    required this.characterModel,
  });

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  late CharacterBloc bloc;

  @override
  void initState() {
    bloc = getIt<CharacterBloc>();
    bloc.add(GetEpisodeEvent(characterResult: widget.characterModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 412.w,
                    height: 218.h,
                    child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                        child: Image.network(
                          widget.characterModel.image ?? "",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    left: 110,
                    top: 138,
                    child: Container(
                      width: 180.r,
                      height: 180.r,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 146.w,
                          height: 146.h,
                          child:
                              Image.network(widget.characterModel.image ?? ""),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 100.h),
            Text(
              widget.characterModel.name ?? "",
              style: const TextStyle(fontSize: 34),
            ),
            SizedBox(height: 4.h),
            Text(
              getStatus(widget.characterModel.status!.index.toString()),
              style: TextStyle(
                  color: getColor(
                    widget.characterModel.status!.index.toString(),
                  ),
                  fontSize: 14),
            ),
            SizedBox(height: 36.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.",
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Пол",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            getGender(
                              widget.characterModel.gender!.index.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 118),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Расса",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            getSpecies(
                              widget.characterModel.species!.index.toString(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Место рождения",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.characterModel.origin?.name ?? ""),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Место положение",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(widget.characterModel.location?.name ?? ""),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  Divider(height: 5.h),
                  SizedBox(
                    height: 36.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "Эпизоды",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "Все эпизоды",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  BlocConsumer<CharacterBloc, CharacterState>(
                    bloc: bloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is CharacterLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      if (state is CharacterEpisodeLoadedState) {
                        print(
                            'state.episodeModelList.length ==== ${state.episodeModelList.length}');

                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.episodeModelList.length,
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
                                            "Серия ${state.episodeModelList[index].id ?? 0}",
                                            style: TextStyle(
                                                color: Color(0xff22A2BD),
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 179.w,
                                            child: Text(
                                              "${state.episodeModelList[index].name}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            "${state.episodeModelList[index].airDate}",
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
                        );
                      }
                      return Container(
                        color: Colors.red,
                        width: 20,
                        height: 30,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
