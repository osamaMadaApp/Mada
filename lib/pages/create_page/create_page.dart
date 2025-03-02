import 'package:Mada/components/check_selection_component/check_selection_component_model.dart';
import 'package:Mada/components/create_vehicle_component/create_vehicle_component.dart';
import 'package:Mada/components/list_selection_component/list_selection_component_model.dart';
import 'package:Mada/components/spic_selection_component/spic_selection_component_model.dart';
import 'package:flutter/foundation.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../backend/schema/util/schema_util.dart';
import '../../components/check_selection_component/check_selection_component.dart';
import '../../components/create_360_component/create_360_component.dart';
import '../../components/create_360_component/create_360_component_model.dart';
import '../../components/create_vehicle_component/create_vehicle_component_model.dart';
import '../../components/create_vehicle_component/create_vehicle_component_model.dart';
import '../../components/list_selection_component/list_selection_component.dart';
import '../../components/spic_selection_component/spic_selection_component.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_widgets.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'create_page_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePage>
    with TickerProviderStateMixin {
  late CreatePageModel _model;
  late Create360ComponentModel _modelCreate360ComponentModel;
  late ListSelectionComponentModel _modelListSelectionComponentModel;
  late ListSelectionComponentModel _modelListmodelComponentModel;
  late ListSelectionComponentModel _modelListCategoryComponentModel;
  late SpicSelectionComponentModel _modelListSpecificationComponentModel;
  late CheckSelectionComponentModel _modelCheckSelectionComponentModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreatePageModel());

    _modelCreate360ComponentModel =
        createModel(context, () => Create360ComponentModel());
    _modelListSelectionComponentModel =
        createModel(context, () => ListSelectionComponentModel());
    _modelListmodelComponentModel =
        createModel(context, () => ListSelectionComponentModel());
    _modelListCategoryComponentModel =
        createModel(context, () => ListSelectionComponentModel());
    _modelListSpecificationComponentModel =
        createModel(context, () => SpicSelectionComponentModel());
    _modelCheckSelectionComponentModel =
        createModel(context, () => CheckSelectionComponentModel());
    _scrollController.addListener(_onScroll);
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
      setState(() {
        _model.isBottom = isBottom;
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
          backgroundColor: FlutterMadaTheme
              .of(context)
              .info,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (_model.currentPageIndex == 0) {
                        context.pop();
                      } else {
                        setState(() {
                          _model.currentPageIndex =
                              (_model.currentPageIndex ?? 0) - 1;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  Text(getSelectedTitle(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ).withFont(
                        fontFamily: AppFonts.lato,
                        fontWeight: AppFonts.bold,
                      )),
                  const Icon(
                    Icons.add_box_rounded,
                    color: Colors.white,
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
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 70),
                      child: currentWidget()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: publicButtonEnabled()
                                  ? () async {
                                if (_model.currentPageIndex == 7) {
                                  await createApi();
                                  return;
                                }
                                setState(() {
                                  _model.currentPageIndex =
                                      (_model.currentPageIndex ?? 0) + 1;
                                });
                              }
                                  : null,
                              text: getSelectedButtonTitle(),
                              options: FFButtonOptions(
                                height: 45,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 0),
                                iconPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 0),
                                color: FlutterMadaTheme
                                    .of(context)
                                    .color000000,
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ).withFont(
                                  fontFamily: AppFonts.lato,
                                  fontWeight: AppFonts.bold,
                                ),
                                elevation: 0,
                                disabledColor: FlutterMadaTheme
                                    .of(context)
                                    .color000000
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  Future createApi() async {
    _model.create = await MyCarApiGroupGroup.createVehicleCall.call(
        authorization: FFAppState().TokenModel.token,
        brandId: _model.selectedBrand?['id'] ?? 0,
        modelId: _model.selectedModel?['id'] ?? 0,
        categoryId: _model.selectedCategory?['id'] ?? 0,
        itemsIds:
        _model.selectedSpic?.values.map((value) => value).toList() ?? [],
        mostSearched: _model.mostSearched ?? false,
        top: _model.top ?? false,
        recommended: _model.recommended ?? false);
    if (_model.create?.jsonBody?['id'] != null) {
      await  uploadeMoainImageMultiPart(_model.create?.jsonBody?['id']);
    } else {
      error(
          context,
          FocusNode(),
          _model.create?.jsonBody != null
              ? (_model.create?.jsonBody['message'].toString() ??
              _model.create?.bodyText)
              : _model.create?.bodyText);
    }
  }

  Future uploadeMoainImageMultiPart(int id) async {
    _model.uploadMainImageIdApiCall = await MyCarApiGroupGroup.uploadMainImageIdApiCall.call(
        context: context,
        authorization: FFAppState().TokenModel.token,
        file: _model.uploadedLocalFile,
        mainImageId: id
    );
    if (_model.uploadMainImageIdApiCall?.jsonBody?['id'] != null) {
     await uploadSecImageIdApiCall(id);
    } else {
      error(
          context,
          FocusNode(),
          _model.uploadMainImageIdApiCall?.jsonBody != null
              ? (_model.uploadMainImageIdApiCall?.jsonBody['message'].toString() ??
              _model.uploadMainImageIdApiCall?.bodyText)
              : _model.uploadMainImageIdApiCall?.bodyText);
    }
  }

  Future uploadSecImageIdApiCall(int id) async {
    _model.uploadSecImageIdApiCall = await MyCarApiGroupGroup.uploadSecImageIdApiCall.call(
        context: context,
        authorization: FFAppState().TokenModel.token,
        file: _model.uploadedLocalFile360,
        mainImageId: id
    );
    if (_model.uploadSecImageIdApiCall?.jsonBody?['id'] != null) {
      await uploadFilesConcurrently(_model.uploadSecImageIdApiCall?.jsonBody?['id']).then((onValue){
         success(
             context,
             FocusNode(),
             FFLocalizations.of(context)
                 .getVariableText(enText: 'Vehicle has been created successfully', arText: 'تم انشاء المركبة بنجاح'))?.then((onValue){
           context.pushNamed('HomePage');
         });

      });
    } else {
      error(
          context,
          FocusNode(),
          _model.uploadSecImageIdApiCall?.jsonBody != null
              ? (_model.uploadSecImageIdApiCall?.jsonBody['message'].toString() ??
              _model.uploadSecImageIdApiCall?.bodyText)
              : _model.uploadSecImageIdApiCall?.bodyText);
    }
  }

  Future<bool> uploadMedia(FFUploadedFile file, int id) async {
    // Check if the file is non-empty
    if (file.bytes?.isEmpty == true) {
      return false;
    }

    // Proceed with the upload
    final response = await MyCarApiGroupGroup.uploadMedia.call(
      context: context,
      authorization: FFAppState().TokenModel.token,
      file: file,
      mainImageId: id,
    );

    return response.jsonBody?['id'] != null;
  }

  Future<bool> uploadFilesConcurrently(int id) async {
    // List of files to upload
    final files = [
      _model.uploadedLocalFile2,
      _model.uploadedLocalFile3,
      _model.uploadedLocalFile4,
      _model.uploadedLocalFile5,
      _model.uploadedLocalFile6,
    ];

    // Filter out null files
    final nonNullFiles = files.where((file) => file != null).cast<FFUploadedFile>().toList();

    // Create a list of upload futures
    final uploadFutures = nonNullFiles.map((file) => uploadMedia(file, id)).toList();

    // Wait for all uploads to complete
    final results = await Future.wait(uploadFutures);

    // Check if all uploads were successful
    return results.every((success) => success);
  }


  // Future uploadMedia(int id) async {
  //   _model.uploadMedia = await MyCarApiGroupGroup.uploadMedia.call(
  //       context: context,
  //       authorization: FFAppState().TokenModel.token,
  //       file: _model.uploadedLocalFile360,
  //       mainImageId: id
  //   );
  //   if (_model.uploadMedia?.jsonBody?['id'] != null) {
  //
  //
  //
  //
  //   } else {
  //     error(
  //         context,
  //         FocusNode(),
  //         _model.uploadMedia?.jsonBody != null
  //             ? (_model.uploadMedia?.jsonBody['message'].toString() ??
  //             _model.uploadMedia?.bodyText)
  //             : _model.uploadMedia?.bodyText);
  //   }
  // }

  Widget createVehicleComponentWidget() {
    return wrapWithModel(
        model: _model.modelCreateVehicleComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: CreateVehicleComponent(
          canEdit: _model.currentPageIndex != 7,
          uploadedLocalFile: (uploadedLocalFile) {
            _model.uploadedLocalFile = uploadedLocalFile ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
            setState(() {});
          },
          uploadedLocalFile2: (uploadedLocalFile2) {
            _model.uploadedLocalFile2 = uploadedLocalFile2 ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
          },
          uploadedLocalFile3: (uploadedLocalFile3) {
            _model.uploadedLocalFile3 = uploadedLocalFile3 ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
          },
          uploadedLocalFile4: (uploadedLocalFile4) {
            _model.uploadedLocalFile4 = uploadedLocalFile4 ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
          },
          uploadedLocalFile5: (uploadedLocalFile5) {
            _model.uploadedLocalFile5 = uploadedLocalFile5 ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
          },
          uploadedLocalFile6: (uploadedLocalFile6) {
            _model.uploadedLocalFile6 = uploadedLocalFile6 ??
                FFUploadedFile(bytes: Uint8List.fromList([]));
          },
        ));
  }

  Widget listSelectionComponentWidget() {
    return wrapWithModel(
        model: _modelCreate360ComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: Create360Component(
            canEdit: _model.currentPageIndex != 7,
            uploadedLocalFile: (uploadedLocalFile) {
              _model.uploadedLocalFile360 = uploadedLocalFile ??
                  FFUploadedFile(bytes: Uint8List.fromList([]));
              setState(() {});
            }));
  }

  Widget listSelectionComponent60C() {
    return wrapWithModel(
        model: _modelListSelectionComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: ListSelectionComponent(
          canEdit: _model.currentPageIndex != 7,
          key: const Key('/brand/list'),
          url: '/brand/list',
          selectedData: (selected) {
            setState(() {
              _model.selectedBrand = selected;
            });
          },
          selectedId: _model.selectedBrand?['id'] ?? 0,
        ));
  }

  Widget listSelectionComponentMain() {
    return wrapWithModel(
        model: _modelListmodelComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: ListSelectionComponent(
          canEdit: _model.currentPageIndex != 7,
          key: Key('/model/list/${_model.selectedBrand?['id'] ?? 0}'),
          url: '/model/list/${_model.selectedBrand?['id'] ?? 0}',
          selectedData: (selected) {
            setState(() {
              _model.selectedModel = selected;
            });
          },
          selectedId: _model.selectedModel?['id'] ?? 0,
        ));
  }

  Widget modelListCategoryComponentModel() {
    return wrapWithModel(
        model: _modelListCategoryComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: ListSelectionComponent(
          canEdit: _model.currentPageIndex != 7,
          key: Key('/category/list/${_model.selectedModel?['id'] ?? 0}'),
          url: '/category/list/${_model.selectedModel?['id'] ?? 0}',
          selectedData: (selected) {
            setState(() {
              _model.selectedCategory = selected;
            });
          },
          selectedId: _model.selectedCategory?['id'] ?? 0,
        ));
  }

  Widget modelListSpecificationComponentModel() {
    return wrapWithModel(
        model: _modelListSpecificationComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: SpicSelectionComponent(
          canEdit: _model.currentPageIndex != 7,
          key: const Key('/specificationGoup/list'),
          url: '/specificationGoup/list',
          selectedData: (selected) {
            setState(() {
              _model.selectedSpecification = selected;
            });
          },
          selectedId: _model.selectedSpecification?['id'] ?? 0,
          selectedSpicIdx: _model.selectedSpic,
          selectedSpic: (selected) {
            setState(() {
              _model.selectedSpic?.addEntries(selected?.entries ?? []);
            });
          },
        ));
  }

  Widget modelCheckSelectionComponentModel() {
    return wrapWithModel(
        model: _modelCheckSelectionComponentModel,
        updateCallback: () => setState(() {}),
        // Ensure UI updates when model changes
        child: CheckSelectionComponent(
          key: const Key('CheckSelectionComponent'),
          mostSearched: _model.mostSearched,
          top: _model.top,
          recommended: _model.recommended,
          canEdit: _model.currentPageIndex != 7,
          selectedData: (mostSearched, top, recommended) {
            setState(() {
              _model.mostSearched = mostSearched;
              _model.top = top;
              _model.recommended = recommended;
            });
          },
        ));
  }

  Widget currentWidget() {
    if (_model.currentPageIndex == 0) {
      return createVehicleComponentWidget();
    } else if (_model.currentPageIndex == 1) {
      return listSelectionComponentWidget();
    } else if (_model.currentPageIndex == 2) {
      return listSelectionComponent60C();
    } else if (_model.currentPageIndex == 3) {
      return listSelectionComponentMain();
    } else if (_model.currentPageIndex == 4) {
      return modelListCategoryComponentModel();
    } else if (_model.currentPageIndex == 5) {
      return modelListSpecificationComponentModel();
    } else if (_model.currentPageIndex == 6) {
      return modelCheckSelectionComponentModel();
    } else if (_model.currentPageIndex == 7) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            createVehicleComponentWidget(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            listSelectionComponentWidget(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            listSelectionComponent60C(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            listSelectionComponentMain(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            modelListCategoryComponentModel(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            modelListSpecificationComponentModel(),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            modelCheckSelectionComponentModel(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  bool isCategorySuccess() {
    if (_model.selectedCategory?['id'] != null) {
      return true;
    }
    return false;
  }

  bool isBrandSuccess() {
    if (_model.selectedBrand?['id'] != null) {
      return true;
    }
    return false;
  }

  bool isModelSuccess() {
    if (_model.selectedModel?['id'] != null) {
      return true;
    }
    return false;
  }

  bool isImageModelSuccess() {
    if (_model.uploadedLocalFile.bytes?.isEmpty != true) {
      return true;
    }
    return false;
  }

  bool is360ImageModelSuccess() {
    if (_model.uploadedLocalFile360.bytes?.isEmpty != true) {
      return true;
    }
    return false;
  }

  bool isSpicSuccess() {
    if (_model.selectedSpic?.isNotEmpty == true) {
      return true;
    }
    return false;
  }

  bool publicButtonEnabled() {
    if (_model.currentPageIndex == 0) {
      if (isImageModelSuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 1) {
      if (is360ImageModelSuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 2) {
      if (isBrandSuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 3) {
      if (isModelSuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 4) {
      if (isCategorySuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 5) {
      if (isSpicSuccess()) {
        return true;
      }
    }
    if (_model.currentPageIndex == 6) {
      return true;
    }
    if (_model.currentPageIndex == 7) {
      return _model.isBottom ?? false;
    }
    return false;
  }

  String getSelectedTitle() {
    if (_model.currentPageIndex == 0) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Upload Images', arText: 'رفع الصور');
    } else if (_model.currentPageIndex == 1) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Upload 360 image', arText: 'رفع صورة ٣٦٠');
    } else if (_model.currentPageIndex == 2) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Select a brand', arText: 'اختر البراند');
    } else if (_model.currentPageIndex == 3) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Select a model', arText: 'اختر الموديل');
    } else if (_model.currentPageIndex == 4) {
      return FFLocalizations.of(context).getVariableText(
          enText: 'Select a Category', arText: 'اختر الكاتيغوري');
    } else if (_model.currentPageIndex == 5) {
      return FFLocalizations.of(context).getVariableText(
          enText: 'Select a Specification', arText: 'اختر التفصيل');
    } else if (_model.currentPageIndex == 6) {
      return FFLocalizations.of(context).getVariableText(
          enText: 'Select a Other Specifications', arText: 'اختر تفاصيل اخرى');
    } else if (_model.currentPageIndex == 7) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Vehicle Details', arText: 'تفاصيل المركبة');
    } else {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Home', arText: 'الرئيسية');
    }
  }

  String getSelectedButtonTitle() {
    if (_model.currentPageIndex == 0) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 1) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 2) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 3) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 4) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 5) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 6) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Next', arText: 'التالي');
    } else if (_model.currentPageIndex == 7) {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Create Car', arText: 'انشاء المركبة');
    } else {
      return FFLocalizations.of(context)
          .getVariableText(enText: 'Home', arText: 'الرئيسية');
    }
  }
}
