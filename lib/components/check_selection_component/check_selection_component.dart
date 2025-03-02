import 'package:flutter/scheduler.dart';

import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'check_selection_component_model.dart';

class CheckSelectionComponent extends StatefulWidget {
  final bool? mostSearched;
  final bool? top;
  final bool? recommended;
  final bool? canEdit;

  final void Function(bool? mostSearched, bool? top, bool? recommended)?
      selectedData;

  const CheckSelectionComponent(
      {super.key,
      this.mostSearched,
      this.top,
      this.recommended,
      this.selectedData,this.canEdit});

  @override
  State<CheckSelectionComponent> createState() =>
      _CheckSelectionPageWidgetState();
}

class _CheckSelectionPageWidgetState extends State<CheckSelectionComponent>
    with TickerProviderStateMixin {
  late CheckSelectionComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckSelectionComponentModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.mostSearched = widget.mostSearched;
        _model.top = widget.top;
        _model.recommended = widget.recommended;
      });
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
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5.0, 0.0, 5.0, 0.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterMadaTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _model.mostSearched ?? false,
                          onChanged: (onChanged) {
                            if(widget.canEdit != true){
                              return;
                            }
                            setState(() {
                              _model.mostSearched = onChanged;
                            });
                            widget.selectedData?.call(_model.mostSearched,
                                _model.top, _model.recommended);
                          }),
                      Text(
                        FFLocalizations.of(context).getVariableText(
                          enText: 'Add to Most Searched',
                          arText: 'أضف إلى الأكثر بحثًا',
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: FlutterMadaTheme.of(context).color000000,
                        ).withFont(
                          fontFamily: AppFonts.lato,
                          fontWeight: AppFonts.bold,
                        ),
                        softWrap: true,
                      )
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5.0, 0.0, 5.0, 0.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterMadaTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _model.top ?? false,
                          onChanged: (onChanged) {
                            if(widget.canEdit != true){
                              return;
                            }
                            setState(() {
                              _model.top = onChanged;
                            });
                            widget.selectedData?.call(_model.mostSearched,
                                _model.top, _model.recommended);
                          }),
                      Text(
                        FFLocalizations.of(context).getVariableText(
                          enText: 'Add to Top Listed',
                          arText: 'أضف إلى القائمة الأعلى',
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: FlutterMadaTheme.of(context).color000000,
                        ).withFont(
                          fontFamily: AppFonts.lato,
                          fontWeight: AppFonts.bold,
                        ),
                        softWrap: true,
                      )
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5.0, 0.0, 5.0, 0.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterMadaTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _model.recommended ?? false,
                          onChanged: (onChanged) {
                            if(widget.canEdit != true){
                              return;
                            }
                            setState(() {
                              _model.recommended = onChanged;
                            });
                            widget.selectedData?.call(_model.mostSearched,
                                _model.top, _model.recommended);
                          }),
                      Text(
                        FFLocalizations.of(context).getVariableText(
                          enText: 'Add to Recommended List',
                          arText: 'أضف إلى القائمة الموصى بها',
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: FlutterMadaTheme.of(context).color000000,
                        ).withFont(
                          fontFamily: AppFonts.lato,
                          fontWeight: AppFonts.bold,
                        ),
                        softWrap: true,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
