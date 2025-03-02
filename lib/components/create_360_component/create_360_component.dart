import 'package:flutter/foundation.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/upload_data.dart';
import '../../pages/details/details_page.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'create_360_component_model.dart';

class Create360Component extends StatefulWidget {
  final void Function(FFUploadedFile? uploadedLocalFile)? uploadedLocalFile;
  final bool? canEdit;
  const Create360Component({
    super.key,
    this.uploadedLocalFile,
    this.canEdit,
  });

  @override
  State<Create360Component> createState() => _Create360PageWidgetState();
}

class _Create360PageWidgetState extends State<Create360Component>
    with TickerProviderStateMixin {
  late Create360ComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Create360ComponentModel());
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
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Row(
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
                                  enText: 'Select 360 Image',
                                  arText: 'رفع صورة ٣٦٠'),
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
                ],
              ),
            ),
            Visibility(
              visible: _model.uploadedLocalFile.bytes?.isEmpty != true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  backgroundColor: Colors.white,
                                  insetPadding: EdgeInsets.zero,
                                  // Removes default padding
                                  child: DetailsPage(
                                    uploadedLocalFile:
                                    _model.uploadedLocalFile,
                                  ));
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                FlutterMadaTheme.of(context).color3252a2,
                                width: 0.5,
                              ),
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                        enText: 'Preview 360 Image',
                                        arText: 'مشاهدة صورة ٣٦٠'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: FlutterMadaTheme.of(context)
                                          .color3252a2,
                                    ).withFont(
                                      fontFamily: AppFonts.lato,
                                      fontWeight: AppFonts.bold,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
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
        maxHeight: 2240,
        maxWidth: 2240);
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
}
