import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../../structure_main_flow/internationalization.dart';
import '../../utils/colors.dart';

class TwoLineHtmlPreview extends StatelessWidget {

  const TwoLineHtmlPreview({
    super.key,
    required this.htmlContent,
    required this.onReadMore,
  });
  final String htmlContent;
  final VoidCallback onReadMore;

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    final plainText = unescape.convert(_stripHtmlTags(htmlContent));
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: plainText, style: textStyle);
        final tp = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
          ellipsis: '...',
        );
        tp.layout(maxWidth: constraints.maxWidth);

        // Get the truncated text that fits 2 lines
        final truncatedText = _getTruncatedText(plainText, textStyle, constraints.maxWidth);

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: truncatedText,
                style: textStyle,
              ),
              TextSpan(
                text: ' ${FFLocalizations.of(context).getText('read_more')} ',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(AppColors.primary),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(AppColors.primary),
                ),
                recognizer: TapGestureRecognizer()..onTap = onReadMore,
              ),
            ],
          ),
        );
      },
    );
  }

  String _stripHtmlTags(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), ' ');
  }

  String _getTruncatedText(String text, TextStyle style, double maxWidth) {
    final words = text.split(' ');
    String result = '';
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '...',
    );

    for (var word in words) {
      final trial = result.isEmpty ? word : '$result $word';
      tp.text = TextSpan(text: '$trial...', style: style);
      tp.layout(maxWidth: maxWidth);

      if (tp.didExceedMaxLines) {
        break;
      }
      result = trial;
    }

    return result;
  }
}

