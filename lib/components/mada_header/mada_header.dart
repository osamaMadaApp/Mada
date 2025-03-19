import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';

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
        icon: SvgPictureRtl.asset(
          iconBack,
        ),
        onPressed: () {
          Navigator.pop(context);
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
                    Navigator.pop(context);
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
