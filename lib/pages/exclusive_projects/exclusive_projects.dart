import '../../components/mada_header/mada_header.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'exclusive_projects_model.dart';

class ExclusiveProjects extends StatefulWidget {
  const ExclusiveProjects({super.key});

  @override
  State<ExclusiveProjects> createState() => _ExclusiveProjectsWidgetState();
}

class _ExclusiveProjectsWidgetState extends State<ExclusiveProjects>
    with TickerProviderStateMixin {
  late ExclusiveProjectsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = context.read<ExclusiveProjectsModel>();
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   _model = context.watch<ExclusiveProjectsModel>();
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: MadaHeader(title: 'exclusive_projects'),
          key: scaffoldKey,
          backgroundColor: FlutterMadaTheme.of(context).info,
          body: SafeArea(
              top: true,
              child: Container()),
        ));
  }
}
