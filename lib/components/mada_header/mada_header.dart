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
        style: TextStyle(
          color: FlutterMadaTheme.of(context).color000000,
          fontSize: 28.0,
          fontFamily: AppFonts.outfit,
          fontWeight: AppFonts.w600,
        ),
      ),
      centerTitle: false,
      backgroundColor: FlutterMadaTheme.of(context).colorFFFFFF,
      elevation: 0.0,
      leading: IconButton(
        icon: SvgPicture.asset(
          iconBack,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      actions: actions ??
          [
            if (withCloseButton)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 72.h,
                ),
                child: GestureDetector(
                  onTap: () async {
                    // consoleLog(Get.currentRoute);
                    context.pop();
                  },
                  child: SvgPicture.asset(iconCloseButton),
                ),
              ),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(72.h);
}
