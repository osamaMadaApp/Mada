import 'package:flutter_svg/svg.dart';

import '../../api/api_request.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class MadaHeader extends StatelessWidget implements PreferredSizeWidget {
  const MadaHeader({
    super.key,
    this.title,
    this.actions,
    this.withCloseButton = false,
  });

  final String? title;
  final List<Widget>? actions;
  final bool withCloseButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text(
        title ?? '',
        style:  TextStyle(
          color: FlutterMadaTheme.of(context).color000000,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: false,
      backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
      elevation: 0.0,
      leading: RotatedBox(
        quarterTurns: isRTL ? 2 : 0,
        child: IconButton(
          icon: SvgPicture.asset(iconBack),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      actions: actions ??
          [
            if (withCloseButton)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kToolbarHeight.h * 0.04,
                ),
                child: GestureDetector(
                  onTap: () async {
                    consoleLog(Get.currentRoute);
                     context.pop();
                  },
                  child: SvgPicture.asset(iconCloseButton),
                ),
              ),
          ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight.h);
}
