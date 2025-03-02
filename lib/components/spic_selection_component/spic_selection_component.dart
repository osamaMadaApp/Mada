import 'dart:collection';
import '../../backend/api_requests/api_calls.dart';
import '../../backend/schema/util/schema_util.dart';
 import 'package:flutter/material.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/flutter_mada_util.dart';
import 'spic_selection_component_model.dart';

class SpicSelectionComponent extends StatefulWidget {
  final String? url;
  final int? selectedId;
  final HashMap<int, int>?  selectedSpicIdx;
  final void Function(dynamic selectedData)? selectedData;
  final void Function(HashMap<int, int>? selectedSpic)? selectedSpic;
  final bool? canEdit;

  const SpicSelectionComponent(
      {super.key, this.url, this.selectedData, this.selectedId,this.selectedSpicIdx,this.selectedSpic,this.canEdit});

  @override
  State<SpicSelectionComponent> createState() =>
      _SpicSelectionPageWidgetState();
}

class _SpicSelectionPageWidgetState extends State<SpicSelectionComponent>
    with TickerProviderStateMixin {
  late SpicSelectionComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool>? expansionStateList;
  HashMap<int, List<dynamic>> listOfItems = HashMap<int, List<dynamic>>();
  HashMap<int, bool> selectedItems = HashMap<int, bool>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpicSelectionComponentModel());
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
      expansionStateList =
          List.generate(_model.listOfLocalCategory.length, (index) => false);
      setState(() {
        _model.isLoading = false;
      });
      setState(() async {
        for (int x = 0; x < _model.listOfLocalCategory.length; x++) {
          final value =  widget.selectedSpicIdx!.containsKey(_model.listOfLocalCategory[x]['id']??'') ? true : false;
          if(value==true){
            await callApiSpic(_model.listOfLocalCategory[x]['id']);
          }
          expansionStateList?[x] =  value;
        }
      });
    } else {
      setState(() {
        _model.isLoading = false;
      });
      error(context, FocusNode(), _model.leaveListApiCall?.bodyText);
    }
  }

 Future callApiSpic(int id) async {
    ApiCallResponse? leaveListApiCall =
        await MyCarApiGroupGroup.multiListCall.call(
      url: '/specificationGoup/specificationItems/$id',
    );
    if ((leaveListApiCall.succeeded ?? true)) {
      dynamic listOfLocalCategory = getJsonField(
            (leaveListApiCall.jsonBody ?? ''),
            r'''$''',
          ) ??
          [];
      setState(() {
        listOfItems[id] = listOfLocalCategory;
        widget.selectedSpicIdx?.forEach((key , value){
          selectedItems[value] = true;
        });
      });
    } else {
      error(context, FocusNode(), leaveListApiCall.bodyText);
    }
  }

  void updateListOfItems(
      HashMap<int, List<dynamic>> listOfItems,
      HashMap<int, int>? selectedSpicIdx,
      ) {
    // Ensure selectedSpicIdx is not null
    if (selectedSpicIdx == null) return;

    // Iterate over each entry in selectedSpicIdx
    selectedSpicIdx.forEach((itemKey, subItemKey) {
      // Check if listOfItems contains the itemKey
      if (listOfItems.containsKey(itemKey)) {
        // Retrieve the list associated with the itemKey
        List<dynamic> subItems = listOfItems[itemKey]!;

        // Iterate over the list to find HashMap<int, bool> entries
        for (var subItem in subItems) {
          if (subItem is HashMap<int, bool>) {
            // Check if the subItem contains the subItemKey
            if (subItem.containsKey(subItemKey)) {
              // Update the bool value to true
              subItem[subItemKey] = true;
            }
          }
        }
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
                    return ExpansionTile(
                      title: Text(
                        positionItem?['name'] ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: FlutterMadaTheme.of(context).color3252a2,
                          fontFamily: AppFonts.lato,
                          fontWeight: AppFonts.bold,
                        ),
                      ),
                      backgroundColor:
                      FlutterMadaTheme.of(context).secondaryBackground,
                      initiallyExpanded: expansionStateList?[index] ?? false,
                      onExpansionChanged: (bool expanding) async{
                        setState(() {
                          expansionStateList?[index] = expanding;
                        });
                        await callApiSpic(positionItem['id']);
                      },
                      trailing: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 0.0),
                        child: (expansionStateList?[index] ?? false)
                            ? Icon(
                          Icons.keyboard_arrow_up,
                          color: FlutterMadaTheme.of(context)
                              .color3252a2,
                        )
                            : Icon(
                          Icons.keyboard_arrow_down,
                          color: FlutterMadaTheme.of(context)
                              .color3252a2,
                        ),
                      ),
                      children: <Widget>[
                        Wrap(
                          spacing: 8.0, // space between items
                          runSpacing: 4.0, // space between rows
                          alignment: WrapAlignment.start,
                          children:
                          (listOfItems[positionItem?['id'] ?? ''] ?? {})
                              .map((item) {
                            return InkWell(
                              onTap: () {
                                if(widget.canEdit != true){
                                  return;
                                }
                                setState(() {
                                  (listOfItems[positionItem?['id'] ?? ''] ??
                                      {})
                                      .map((item) {
                                    selectedItems[item['id'] ?? ''] = false;
                                  }).toList();

                                  selectedItems[item['id'] ?? ''] =
                                  !(selectedItems[item['id'] ?? ''] ??
                                      false);
                                  updateSelectedSpic(positionItem?['id'] ?? 0,item['id'] ?? 0);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: selectedItems[item['id'] ?? ''] ==
                                      true
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text(
                                  item['name'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: FlutterMadaTheme.of(context)
                                        .colorFFFFFF,
                                  ).withFont(
                                    fontFamily: AppFonts.lato,
                                    fontWeight: AppFonts.bold,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
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

  void updateSelectedSpic(int key , int value) {
    var selectedSpicMap = HashMap<int, int>();
    selectedSpicMap[key] = value;
    if (widget.selectedSpic != null) {
       widget.selectedSpic?.call(selectedSpicMap);
    }
  }
}
