import '../../general_exports.dart';

class MadaText extends StatelessWidget {
  const MadaText(
    String this.text, {
    this.style,
    super.key,
    this.softWarp,
    this.textAlign,
    this.maxLines,
  });

  final String? text;
  final TextStyle? style;
  final bool? softWarp;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ??
          Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: FlutterMadaTheme.of(context).primary,
              ),
      softWrap: softWarp,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
