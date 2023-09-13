import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/characters/data/models/character_model.dart';
import 'package:rick_morty/features/characters/presentation/logic/bloc/character_bloc.dart';
import 'package:rick_morty/features/characters/presentation/screens/character_screen/character_info.dart';
import 'package:rick_morty/features/characters/presentation/widgets/custom_textField.dart';
import 'package:rick_morty/internal/dependecies/get_it.dart';
import 'package:rick_morty/internal/helpers/utils.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late ScrollController scrollController;
  late CharacterBloc bloc;
  late bool isListView;

  List<CharacterResult> characterResultList = [];
  int counter = 1;
  bool isLoading = false;

  @override
  void initState() {
    bloc = getIt<CharacterBloc>();
    bloc.add(GetCharacterEvent(
      isFirstCall: true,
      page: counter,
    ));

    isListView = true;

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (characterResultList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          counter = counter + 1;

          bloc.add(GetCharacterEvent(
            isFirstCall: false,
            page: counter,
          ));
        }
      }
    }
  }

  //   Route createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation, ) =>  CharacterInfo(
  //                                           characterModel:
  //                                               characterResultList[index],
  //                                         ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CharacterBloc, CharacterState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CharacterLoadedState) {
            characterResultList.addAll(state.characterModel.results ?? []);

            isLoading = false;
          }
        },
        builder: (context, state) {
          if (state is CharacterLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CharacterLoadedState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ВСЕГО ПЕРСОНАЖЕЙ: ${state.characterModel.info!.count}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isListView = !isListView;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 24.r,
                          width: 24.r,
                          child: isListView
                              ? Image.asset("assets/images/Row.png")
                              : Image.asset("assets/images/Grid.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Expanded(
                    child: isListView
                        ? RefreshIndicator(
                            onRefresh: () async {
                              characterResultList.clear();

                              bloc.add(GetCharacterEvent(
                                isFirstCall: true,
                                page: counter,
                              ));
                            },
                            child: ListView.separated(
                              controller: scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: characterResultList.length,
                              itemBuilder: (context, index) {
                                if (index >= characterResultList.length - 1) {
                                  return Platform.isIOS
                                      ? CupertinoActivityIndicator(radius: 15.r)
                                      : Center(
                                          child: CircularProgressIndicator());
                                }

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CharacterInfo(
                                          characterModel:
                                              characterResultList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 74.r,
                                        width: 74.r,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(500).r,
                                          child: Image.network(
                                            characterResultList[index]
                                                .image
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
                                            getStatus(characterResultList[index]
                                                .status),
                                            style: TextStyle(
                                                color: getColor(
                                                    characterResultList[index]
                                                        .status),
                                                fontSize: 10),
                                          ),
                                          Text(
                                            characterResultList[index]
                                                .name
                                                .toString(),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "",
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${getSpecies(characterResultList[index].species)}",
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12)),
                                                TextSpan(
                                                  text:
                                                      ",  ${getGender(characterResultList[index].gender)}",
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
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 24.h);
                              },
                            ),
                          )
                        : GridView.builder(
                            controller: scrollController,
                            itemCount: characterResultList.length,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 60,
                            ),
                            itemBuilder: (context, index) {
                              if (index >= characterResultList.length - 1) {
                                return Platform.isIOS
                                    ? CupertinoActivityIndicator(radius: 15.r)
                                    : Center(
                                        child: CircularProgressIndicator());
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CharacterInfo(
                                        characterModel:
                                            characterResultList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 100.r,
                                      height: 100.r,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        child: Image.network(
                                            characterResultList[index].image ??
                                                ''),
                                      ),
                                    ),
                                    Text(
                                      getStatus(characterResultList[index]
                                              .status
                                              ?.index ??
                                          ""),
                                      style: TextStyle(
                                          color: getColor(
                                            characterResultList[index]
                                                    .status
                                                    ?.index ??
                                                '',
                                          ),
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      characterResultList[index]
                                          .name
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "",
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text: getSpecies(
                                                  characterResultList[index]
                                                          .species
                                                          ?.index ??
                                                      ""),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp)),
                                          TextSpan(
                                            text:
                                                ",  ${getGender(characterResultList[index].gender?.index ?? '')}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                  ),
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
