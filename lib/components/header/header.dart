import 'package:Mada/structure_main_flow/flutter_mada_theme.dart';
import 'package:flutter/material.dart';

import '../../structure_main_flow/internationalization.dart';

class Header extends StatelessWidget {
  final String? title;

  final String? actionTitle;

  final void Function()? action;

  const Header({super.key, this.title, this.action, this.actionTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ).withFont(
                    fontFamily: AppFonts.lato,
                    fontWeight: AppFonts.bold,
                  )),
              InkWell(
                onTap: action,
                child: Text(
                    FFLocalizations.of(context)
                        .getVariableText(enText: 'View all', arText: 'عرض الكل'),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xffF7C475),
                    ).withFont(
                      fontFamily: AppFonts.lato,
                      fontWeight: AppFonts.regular,
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
