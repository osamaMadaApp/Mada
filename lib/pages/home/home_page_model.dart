import 'package:carousel_slider/carousel_controller.dart';

import '../../backend/api_requests/api_manager.dart';
 import '../../structure_main_flow/flutter_mada_model.dart';
import 'home_page.dart' show HomePage;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterMadaModel<HomePage> {


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
