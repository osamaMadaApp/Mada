import 'package:flutter/foundation.dart';
 import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import '../../structure_main_flow/internationalization.dart';
import '../../structure_main_flow/upload_data.dart';
import '../../structure_main_flow/uploaded_file.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'create_vehicle_component_model.dart';

class CreateVehicleComponent extends StatefulWidget {
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile;
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile2;
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile3;
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile4;
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile5;
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile6;
  final bool? canEdit;

  const CreateVehicleComponent({
    super.key,
    this.uploadedLocalFile,
    this.uploadedLocalFile2,
    this.uploadedLocalFile3,
    this.uploadedLocalFile4,
    this.uploadedLocalFile5,
    this.uploadedLocalFile6,
    this.canEdit,
  });

  @override
  State<CreateVehicleComponent> createState() =>
      _CreateVehiclePageWidgetState();
}

class _CreateVehiclePageWidgetState extends State<CreateVehicleComponent>
    with TickerProviderStateMixin {
  late CreateVehicleComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateVehicleComponentModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if(widget.canEdit != true){
                        return;
                      }
                      uploadImage().then((onValue) {
                        setState(() {
                          _model.uploadedLocalFile = onValue!;
                        });
                        widget.uploadedLocalFile
                            ?.call(_model.uploadedLocalFile);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          displayImage(
                            _model.uploadedLocalFile,
                            FFLocalizations.of(context).getVariableText(
                                enText: 'Main Image',
                                arText: 'الصورة الرئيسية'),
                            16.0,
                            const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            const EdgeInsets.fromLTRB(0, 64, 0, 64),
                            const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            144,
                            240,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            if(widget.canEdit != true){
                              return;
                            }
                            uploadImage().then((onValue) {
                              setState(() {
                                _model.uploadedLocalFile2 = onValue!;
                              });
                              widget.uploadedLocalFile2
                                  ?.call(_model.uploadedLocalFile2);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                displayImage(
                                    _model.uploadedLocalFile2,
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                        enText: 'Second Image',
                                        arText: 'الصورة الثانية'),
                                    14.0,
                                    const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    const EdgeInsets.fromLTRB(0, 23, 0, 23),
                                    const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    68,
                                    108)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        if(widget.canEdit != true){
                          return;
                        }
                        uploadImage().then((onValue) {
                          setState(() {
                            _model.uploadedLocalFile3 = onValue!;
                          });
                          widget.uploadedLocalFile3
                              ?.call(_model.uploadedLocalFile3);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            displayImage(
                                _model.uploadedLocalFile3,
                                FFLocalizations.of(context).getVariableText(
                                    enText: 'Third Image',
                                    arText: 'الصورة الثالثة'),
                                14.0,
                                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                const EdgeInsets.fromLTRB(0, 23, 0, 23),
                                const EdgeInsets.fromLTRB(22, 8, 22, 0),
                                61,
                                108)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () async {
                        if(widget.canEdit != true){
                          return;
                        }
                        uploadImage().then((onValue) {
                          setState(() {
                            _model.uploadedLocalFile4 = onValue!;
                          });
                          widget.uploadedLocalFile4
                              ?.call(_model.uploadedLocalFile4);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            displayImage(
                                _model.uploadedLocalFile4,
                                FFLocalizations.of(context).getVariableText(
                                    enText: 'Furth Image',
                                    arText: 'الصورة الرابعة'),
                                14.0,
                                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                const EdgeInsets.fromLTRB(22, 8, 22, 0),
                                75,
                                108)
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                      onTap: () async {
                        if(widget.canEdit != true){
                          return;
                        }
                        uploadImage().then((onValue) {
                          setState(() {
                            _model.uploadedLocalFile5 = onValue!;
                          });
                          widget.uploadedLocalFile5
                              ?.call(_model.uploadedLocalFile5);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            displayImage(
                                _model.uploadedLocalFile5,
                                FFLocalizations.of(context).getVariableText(
                                    enText: 'Fifth Image',
                                    arText: 'الصورة الخامسة'),
                                14.0,
                                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                const EdgeInsets.fromLTRB(22, 8, 22, 0),
                                75,
                                108)
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                      onTap: () async {
                        if(widget.canEdit != true){
                          return;
                        }
                        uploadImage().then((onValue) {
                          setState(() {
                            _model.uploadedLocalFile6 = onValue!;
                          });
                          widget.uploadedLocalFile6
                              ?.call(_model.uploadedLocalFile6);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            displayImage(
                                _model.uploadedLocalFile6,
                                FFLocalizations.of(context).getVariableText(
                                    enText: 'Six Image',
                                    arText: 'الصورة السادسة'),
                                14.0,
                                const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                const EdgeInsets.fromLTRB(22, 8, 22, 0),
                                75,
                                108)
                          ],
                        ),
                      ),
                    )),
              ],
            )
          ],
        ));
  }

  String getSelectedTitle() {
    if (_model.currentPageIndex == 0) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Upload Images', arText: 'رفع الصور');
    } else {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Home', arText: 'الرئيسية');
    }
  }

  Widget displayImage(
    FFUploadedFile uploadedLocalFile,
    String text,
    double fontSize,
    EdgeInsetsGeometry mainMargin,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    double height,
    double width,
  ) {
    if (uploadedLocalFile.bytes != null &&
        uploadedLocalFile.bytes!.isNotEmpty) {
      return Container(
        margin: mainMargin,
        child: Wrap(
          children: [
            Image.memory(
              height: height,
              width: width,
              uploadedLocalFile.bytes!,
              fit: BoxFit.fill, // Adjust as needed
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: padding,
        margin: margin,
        child: Text(text,
            style: TextStyle(
              fontSize: fontSize,
              color: FlutterMadaTheme.of(context).color000000,
            ).withFont(
              fontFamily: AppFonts.lato,
              fontWeight: AppFonts.bold,
            )),
      );
    }
  }

  Future<FFUploadedFile?> uploadImage() async {
    final selectedMedia = await selectMedia(
        mediaSource: MediaSource.photoGallery,
        multiImage: false,
        maxHeight: 300,
        maxWidth: 300);
    if (selectedMedia != null &&
        selectedMedia
            .every((m) => validateFileFormat(m.storagePath, context))) {
      var selectedUploadedFiles = <FFUploadedFile>[];
      try {
        selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                ))
            .toList();
      } finally {}
      if (selectedUploadedFiles.length == selectedMedia.length) {
        return await compute(resizeImageIfNeeded, selectedUploadedFiles.first);
      } else {
        setState(() {});
      }
    }
    return null;
  }

  String getSelectedButtonTitle() {
    if (_model.currentPageIndex == 0) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Upload', arText: 'رفع');
    } else {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Home', arText: 'الرئيسية');
    }
  }
}
