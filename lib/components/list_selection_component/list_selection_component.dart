import 'package:cached_network_image/cached_network_image.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../backend/schema/util/schema_util.dart';
 import 'package:flutter/material.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import 'list_selection_component_model.dart';

class ListSelectionComponent extends StatefulWidget {
  final String? url;
  final int? selectedId;
  final void Function(dynamic selectedData)? selectedData;
  final bool? canEdit;

  const ListSelectionComponent(
      {super.key, this.url, this.selectedData, this.selectedId , this.canEdit,});

  @override
  State<ListSelectionComponent> createState() =>
      _ListSelectionPageWidgetState();
}

class _ListSelectionPageWidgetState extends State<ListSelectionComponent>
    with TickerProviderStateMixin {
  late ListSelectionComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListSelectionComponentModel());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.isLoading = true;
      });
      callApi();
    });
  }

  callApi() async {
    setState(() {
      _model.isLoading = true;
    });
    _model.leaveListApiCall = await MyCarApiGroupGroup.multiListCall.call(
      url: widget.url ?? '',
    );
    if ((_model.leaveListApiCall?.succeeded ?? true)) {
      _model.listOfLocalCategory = getJsonField(
            (_model.leaveListApiCall?.jsonBody ?? ''),
            r'''$''',
          ) ??
          [];
      setState(() {
        _model.isLoading = false;
      });
    } else {
      setState(() {
        _model.isLoading = false;
      });
      error(context, FocusNode(), _model.leaveListApiCall?.bodyText);
    }
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
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5.0, 0.0, 5.0, 0.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _model.listOfLocalCategory.length,
                  itemBuilder: (context, index) {
                    final positionItem = _model.listOfLocalCategory[index];
                    return InkWell(
                      onTap: () {
                        if(widget.canEdit != true){
                          return;
                        }
                        widget.selectedData?.call(positionItem);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterMadaTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        positionItem?['image_path'] !=null? const EdgeInsetsDirectional
                                            .fromSTEB(10.0,
                                            10.0, 10.0, 10.0) : const EdgeInsetsDirectional
                                            .fromSTEB(10.0,
                                            30.0, 10.0, 30.0) ,
                                        child: Visibility(
                                          visible: positionItem?['image_path'] !=null,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                0.0),
                                            child:
                                            CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              fadeInDuration:
                                              const Duration(
                                                  milliseconds:
                                                  200),
                                              fadeOutDuration:
                                              const Duration(
                                                  milliseconds:
                                                  200),
                                              imageUrl: positionItem[
                                              'image_path'] ??
                                                  '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            positionItem?[
                                            'title'] ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: FlutterMadaTheme.of(
                                                  context)
                                                  .color3252a2,
                                            ).withFont(
                                              fontFamily:
                                              AppFonts
                                                  .lato,
                                              fontWeight:
                                              AppFonts
                                                  .bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional
                                        .fromSTEB(10.0,
                                        0.0, 10.0,  0.0),
                                    child: Icon(
                                      positionItem?['id'] ==
                                          widget.selectedId
                                          ? Icons
                                          .radio_button_checked
                                          : Icons
                                          .radio_button_off,
                                      color: FlutterMadaTheme.of(
                                          context)
                                          .color3252a2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
            Visibility(
              visible: _model.listOfLocalCategory.isEmpty == true &&
                  _model.isLoading == false,
              child: Center(
                  child: Text(
                      FFLocalizations.of(context).getVariableText(
                        enText: 'No data is found !',
                        arText: 'لم يتم العثور على اي بيانات !',
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: FlutterMadaTheme.of(context).color000000,
                      ).withFont(
                        fontFamily: AppFonts.lato,
                        fontWeight: AppFonts.bold,
                      ))),
            ),
            Visibility(
              visible: _model.isLoading == true,
              child: Center(
                child: CircularProgressIndicator(
                  color: FlutterMadaTheme.of(context).color3252a2,
                  strokeWidth: 4,
                ),
              ),
            )
          ],
        ));
  }
}
