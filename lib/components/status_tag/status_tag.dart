import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusTag extends StatelessWidget {
  final Color color;
  final String text;

  const StatusTag({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      margin: EdgeInsets.fromLTRB(6.w, 0, 6.w, 0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            width: 12,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              fontFamily: 'Outfit', // Replace if you use AppFonts.outfit
            ),
          ),
        ],
      ),
    );
  }
}
