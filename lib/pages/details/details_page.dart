 import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/uploaded_file.dart';
import 'details_page_model.dart';
import 'package:panorama/panorama.dart';

class DetailsPage extends StatefulWidget {

  final FFUploadedFile? uploadedLocalFile;

  const DetailsPage({super.key,this.uploadedLocalFile});

  @override
  State<DetailsPage> createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late DetailsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailsPageModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude;
      _lat = latitude;
      _tilt = tilt;
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
          appBar: AppBar(
            backgroundColor:  Colors.black,

          ),
          key: scaffoldKey,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Panorama(
                    animSpeed: 1.0,
                    sensorControl: SensorControl.Orientation,
                    onViewChanged: onViewChanged,
                    onTap: (longitude, latitude, tilt) =>
                        print('onTap: $longitude, $latitude, $tilt'),
                    onLongPressStart: (longitude, latitude, tilt) =>
                        print('onLongPressStart: $longitude, $latitude, $tilt'),
                    onLongPressMoveUpdate: (longitude, latitude, tilt) => print(
                        'onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
                    onLongPressEnd: (longitude, latitude, tilt) =>
                        print('onLongPressEnd: $longitude, $latitude, $tilt'),//uploadedLocalFile
                    child: Image.memory(
                      widget.uploadedLocalFile!.bytes!,
                      fit: BoxFit.fill, // Adjust as needed
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
