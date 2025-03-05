import 'package:flutter/scheduler.dart';
import '../../structure_main_flow/flutter_mada_model.dart';
import '/structure_main_flow/flutter_mada_util.dart';
import 'package:flutter/material.dart';
import 'login_side_component_model.dart';

class LoginSideComponent extends StatefulWidget {
  const LoginSideComponent({
    super.key,
  });

  @override
  State<LoginSideComponent> createState() => _LoginSideComponent();
}

class _LoginSideComponent extends State<LoginSideComponent> {
  late LoginSideComponentModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginSideComponentModel());
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
          children: [],
        ));
  }
}
