import 'package:carousel_slider/carousel_slider.dart';

import '../../backend/api_requests/api_calls.dart';
import '../../components/header/header.dart';
import '../../components/view/view_grid.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'home_page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePage>
    with TickerProviderStateMixin {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.getSliderCall = await MyCarApiGroupGroup.getSliderCall
          .call(authorization: FFAppState().TokenModel.token);
      if ((_model.getSliderCall?.succeeded ?? true)) {
        setState(() {
          _model.listOfBanners = getJsonField(
                (_model.getSliderCall?.jsonBody ?? ''),
                r'''$''',
              ) ??
              [];
        });
      }

      _model.getCarsCall = await MyCarApiGroupGroup.getCarsCall
          .call(mostSearched: false, top: false, recommended: false);
      if ((_model.getSliderCall?.succeeded ?? true)) {
        setState(() {
          _model.listOfCars = _model.getSliderCall?.jsonBody ?? [];
        });
      }
      _model.getCarsMostCall = await MyCarApiGroupGroup.getCarsCall
          .call(mostSearched: true, top: false, recommended: false);
      if ((_model.getCarsMostCall?.succeeded ?? true)) {
        setState(() {
          _model.listOfMost = _model.getCarsMostCall?.jsonBody['data'] ?? [];
        });
      }
      _model.getCarsRecommandCall = await MyCarApiGroupGroup.getCarsCall
          .call(mostSearched: false, top: false, recommended: true);
      if ((_model.getCarsRecommandCall?.succeeded ?? true)) {
        setState(() {
          _model.listOfRecommand =
              _model.getCarsRecommandCall?.jsonBody['data'] ?? [];
        });
      }
      _model.getCarsTopCall = await MyCarApiGroupGroup.getCarsCall
          .call(mostSearched: false, top: true, recommended: false);
      if ((_model.getCarsTopCall?.succeeded ?? true)) {
        setState(() {
          _model.listOfTop = _model.getCarsTopCall?.jsonBody['data'] ?? [];
        });
      }

      ///
      _model.getFavList = await MyCarApiGroupGroup.getFavList.call(
        //addFavList
        authorization: FFAppState().TokenModel.token,
      );
      if ((_model.getFavList?.succeeded ?? true)) {
        setState(() {
          _model.listFavItems = _model.getFavList?.jsonBody['data'] ?? [];
          for (var action in _model.listFavItems) {
            _model.listOfMaps[action['id']] = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterMadaTheme.of(context).info,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  ),
                  Text(
                      FFLocalizations.of(context)
                          .getVariableText(enText: 'Home', arText: 'الرئيسية'),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ).withFont(
                        fontFamily: AppFonts.lato,
                        fontWeight: AppFonts.bold,
                      )),
                  InkWell(
                    onTap: () {
                      context.pushNamed('CreatePage');
                    },
                    child: const Icon(
                      Icons.add_box_rounded,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                      '${FFLocalizations.of(context).getVariableText(enText: 'Hi', arText: 'مرحبا')} ${FFAppState().UserModelAppState.name}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ).withFont(
                                        fontFamily: AppFonts.lato,
                                        fontWeight: AppFonts.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(FFAppState().UserModel.name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ).withFont(
                                        fontFamily: AppFonts.lato,
                                        fontWeight: AppFonts.bold,
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                  FFLocalizations.of(context).getVariableText(
                                      enText: 'Search your favourite car here',
                                      arText: 'ابحث عن سيارتك المفضلة هنا'),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF979797),
                                  ).withFont(
                                    fontFamily: AppFonts.lato,
                                    fontWeight: AppFonts.regular,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Visibility(
                            visible: _model.listOfBanners.isNotEmpty,
                            child: Builder(
                              builder: (context) {
                                final sliderSlideList =
                                    _model.listOfBanners.map((e) => e).toList();
                                return CarouselSlider.builder(
                                  itemCount: sliderSlideList.length,
                                  itemBuilder:
                                      (context, sliderSlideListIndex, _) {
                                    final sliderSlideListItem =
                                        sliderSlideList[sliderSlideListIndex];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1, 0),
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          10, 0, 10, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.1,
                                                            decoration: BoxDecoration(
                                                                color: const Color(
                                                                    0xFFF7C475),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            19)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      20,
                                                                      10,
                                                                      20),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                      sliderSlideListItem?[
                                                                              'title'] ??
                                                                          '',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        color: FlutterMadaTheme.of(context)
                                                                            .color000000,
                                                                      ).withFont(
                                                                        fontFamily:
                                                                            AppFonts.lato,
                                                                        fontWeight:
                                                                            AppFonts.bold,
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(
                                                                      sliderSlideListItem?[
                                                                              'description'] ??
                                                                          '',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        color: FlutterMadaTheme.of(context)
                                                                            .color000000,
                                                                      ).withFont(
                                                                        fontFamily:
                                                                            AppFonts.lato,
                                                                        fontWeight:
                                                                            AppFonts.regular,
                                                                      )),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  FFButtonWidget(
                                                                    onPressed:
                                                                        () {
                                                                      context.pushNamed(
                                                                          'DetailsPage');
                                                                    },
                                                                    text: FFLocalizations.of(context).getVariableText(
                                                                        enText:
                                                                            'Explore',
                                                                        arText:
                                                                            'استكشف'),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          30,
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                      iconPadding:
                                                                          const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      color: FlutterMadaTheme.of(
                                                                              context)
                                                                          .color000000,
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .white,
                                                                      ).withFont(
                                                                        fontFamily:
                                                                            AppFonts.lato,
                                                                        fontWeight:
                                                                            AppFonts.bold,
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child: Image.network(
                                                        sliderSlideListItem?[
                                                                'full_media'] ??
                                                            '',
                                                        width: 180,
                                                        height: 150,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  carouselController:
                                      _model.carouselController ??=
                                          CarouselSliderController(),
                                  options: CarouselOptions(
                                    initialPage:
                                        min(1, sliderSlideList.length - 1),
                                    viewportFraction: 1.3,
                                    disableCenter: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.2,
                                    enlargeFactor: 1.0,
                                    enableInfiniteScroll: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 3000),
                                    autoPlayInterval:
                                        const Duration(seconds: 10),
                                    autoPlayCurve: Curves.linear,
                                    pauseAutoPlayInFiniteScroll: true,
                                    onPageChanged: (index, _) =>
                                        _model.carouselCurrentIndex = index,
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: _model.listOfMost.isNotEmpty,
                            child: Header(
                              title: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'The most searched cars',
                                      arText: 'السيارات الأكثر بحثا'),
                              actionTitle: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'View all', arText: 'عرض الكل'),
                              action: () {},
                            ),
                          ),
                          Visibility(
                            visible: _model.listOfMost.isNotEmpty,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 10, // Spacing between columns
                                mainAxisSpacing: 10, // Spacing between rows
                              ),
                              itemBuilder: (context, index) {
                                dynamic item = _model.listOfMost[index];
                                return ViewGrid(
                                  isClicked: () {},
                                  isLikedFunc: () {
                                    setState(() {
                                      if (_model.listOfMaps.containsKey(item['id'])) {
                                        bool? innerMap = _model.listOfMaps[item['id']];
                                        _model.listOfMaps[item['id']] = !innerMap!;
                                      } else {
                                        _model.listOfMaps[item['id']] = true;
                                      }
                                      if(_model.listOfMaps[item['id']] == true){
                                        addAsLiked(item['id']);
                                      }else{
                                        removedLiked(item['id']);
                                      }
                                    });
                                  },
                                  isLiked:  _model.listOfMaps[item['id']] ?? false,
                                  itemInfo: item,
                                );
                              },
                              itemCount: _model
                                  .listOfMost.length, // Number of grid items
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _model.listOfRecommand.isNotEmpty,
                            child: Header(
                              title: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'Recommended Cars for you',
                                      arText: 'السيارات الموصى بها لك'),
                              actionTitle: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'View all', arText: 'عرض الكل'),
                              action: () {},
                            ),
                          ),
                          Visibility(
                            visible: _model.listOfRecommand.isNotEmpty,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 10, // Spacing between columns
                                mainAxisSpacing: 10, // Spacing between rows
                              ),
                              itemBuilder: (context, index) {
                                dynamic item = _model.listOfRecommand[index];
                                return ViewGrid(
                                  isClicked: () {},
                                  isLikedFunc: () {
                                    setState(() {
                                      if (_model.listOfMaps.containsKey(item['id'])) {
                                        bool? innerMap = _model.listOfMaps[item['id']];
                                        _model.listOfMaps[item['id']] = !innerMap!;
                                      } else {
                                        _model.listOfMaps[item['id']] = true;
                                      }
                                      if(_model.listOfMaps[item['id']] == true){
                                        addAsLiked(item['id']);
                                      }else{
                                        removedLiked(item['id']);
                                      }
                                    });
                                  },
                                  isLiked:  _model.listOfMaps[item['id']] ?? false,
                                  itemInfo: item,
                                );
                              },
                              itemCount: _model.listOfRecommand
                                  .length, // Number of grid items
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: _model.listOfTop.isNotEmpty,
                            child: Header(
                              title: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'Top Rated Cars for you',
                                      arText: 'السيارات الاعلى تقيما لك'),
                              actionTitle: FFLocalizations.of(context)
                                  .getVariableText(
                                      enText: 'View all', arText: 'عرض الكل'),
                              action: () {},
                            ),
                          ),
                          Visibility(
                            visible: _model.listOfTop.isNotEmpty,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 10, // Spacing between columns
                                mainAxisSpacing: 10, // Spacing between rows
                              ),
                              itemBuilder: (context, index) {
                                dynamic item = _model.listOfTop[index];
                                return ViewGrid(
                                  isClicked: () {},
                                  isLikedFunc: () {
                                    setState(() {
                                      if (_model.listOfMaps.containsKey(item['id'])) {
                                        bool? innerMap = _model.listOfMaps[item['id']];
                                        _model.listOfMaps[item['id']] = !innerMap!;
                                      } else {
                                        _model.listOfMaps[item['id']] = true;
                                      }
                                      if(_model.listOfMaps[item['id']] == true){
                                        addAsLiked(item['id']);
                                      }else{
                                        removedLiked(item['id']);
                                      }
                                    });
                                  },
                                  isLiked:  _model.listOfMaps[item['id']] ?? false,
                                  itemInfo: item,
                                );
                              },
                              itemCount: _model
                                  .listOfTop.length, // Number of grid items
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  void addAsLiked(int id) async {
    _model.addFavList = await MyCarApiGroupGroup.addFavList.call(
        //addFavList
        authorization: FFAppState().TokenModel.token,
        id: id);
    if ((_model.addFavList?.succeeded ?? true)) {
      setState(() {});
    }
  }

  void removedLiked(int id) async {
    _model.removeFromFav = await MyCarApiGroupGroup.removeFavList.call(
      //addFavList
        authorization: FFAppState().TokenModel.token,
        id: id);
    if ((_model.removeFromFav?.succeeded ?? true)) {
      setState(() {});
    }
  }
}
