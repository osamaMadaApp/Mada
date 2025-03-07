import 'package:flutter/scheduler.dart';

import '/structure_main_flow/flutter_mada_util.dart';
import '../../components/header_widget/header_widget.dart';
import '../../general_exports.dart';
import '../../index.dart';
import 'home_page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePage>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        child: const Column(
          children: <Widget>[
            HeaderWidget(
              profilePicture: testImage,
              firstName: 'John Doe',
            ),
          ],
        ),
      ),
    );
  }
}
