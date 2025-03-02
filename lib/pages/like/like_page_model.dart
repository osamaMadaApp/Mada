import 'package:carousel_slider/carousel_controller.dart';

import '../../backend/api_requests/api_manager.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'like_page.dart' show LikePage;
import 'package:flutter/material.dart';

class LikePageModel extends FlutterMadaModel<LikePage> {


  ApiCallResponse? getUserByIdCall;
  ApiCallResponse? getSliderCall;
  ApiCallResponse? getCarsCall;
  ApiCallResponse? getCarsMostCall;
  ApiCallResponse? getCarsTopCall;
  ApiCallResponse? getFavList;
  ApiCallResponse? addFavList;
  ApiCallResponse? removeFromFav;
  ApiCallResponse? getCarsRecommandCall;
  List<dynamic> listOfBanners = [];
  List<dynamic> listOfCars = [];
  List<dynamic> listOfMost = [];
  List<dynamic> listOfTop = [];
  List<dynamic> listFavItems = [];
  List<dynamic> listOfRecommand = [];
  Map<int? , bool?> listOfMaps = {};
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;


  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
  }
}
