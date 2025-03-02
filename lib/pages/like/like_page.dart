import 'package:carousel_slider/carousel_slider.dart';

import '../../backend/api_requests/api_calls.dart';
import '../../components/header/header.dart';
import '../../components/view/view_grid.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'like_page_model.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageWidgetState();
}

class _LikePageWidgetState extends State<LikePage>
    with TickerProviderStateMixin {
  late LikePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LikePageModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ///
      _model.getFavList = await MyCarApiGroupGroup.getFavList.call(
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
                          .getVariableText(enText: 'Favorite', arText: 'المفضلة'),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ).withFont(
                        fontFamily: AppFonts.lato,
                        fontWeight: AppFonts.bold,
                      )),
                  const Icon(
                    color: Colors.white,
                    Icons.add_box_rounded,
                    size: 25,
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
                    padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Visibility(
                            visible: _model.listFavItems.isNotEmpty,
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
                                dynamic item = _model.listFavItems[index];
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
                                        addAsLiked(item['vehicle']['id']);
                                      }else{
                                        removedLiked(item['vehicle']['id']);
                                      }
                                    });
                                  },
                                  isLiked:  _model.listOfMaps[item['id']] ?? false,
                                  itemInfo: item['vehicle'],
                                );
                              },
                              itemCount: _model
                                  .listFavItems.length, // Number of grid items
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
