import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 import '../../structure_main_flow/flutter_mada_theme.dart';
import '../../structure_main_flow/internationalization.dart';

class ViewGrid extends StatelessWidget {
  final dynamic itemInfo;
  final void Function()? isLikedFunc;
  final void Function()? isClicked;
  final bool? isLiked;

  const ViewGrid(
      {super.key,
      this.itemInfo,
      this.isClicked,
      this.isLikedFunc,
      this.isLiked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(19)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: isLikedFunc,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isLiked != true
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 25,
                        )
                      : const Icon(
                          Icons.favorite_outlined,
                          color: Colors.orange,
                          size: 25,
                        )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: (itemInfo['vehicle_main_image'] != null &&
                          itemInfo['vehicle_main_image']['image_path'] != null)
                      ? Image.network(
                          itemInfo['vehicle_main_image']
                              ['image_path'], //Vector.png
                          width: 113,
                          height: 64,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox(
                          width: 113,
                          height: 64,
                        ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(11)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              (itemInfo['brand'] != null &&
                                  itemInfo['brand']['title'] != null) ? itemInfo['brand']['title'] : '',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: FlutterMadaTheme.of(context).color000000,
                              ).withFont(
                                fontFamily: AppFonts.lato,
                                fontWeight: AppFonts.bold,
                              )),
                          const SizedBox(height: 5),
                          Text(
                              (itemInfo['model'] != null &&
                                  itemInfo['model']['title'] != null) ? itemInfo['model']['title'] : '',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: FlutterMadaTheme.of(context).color000000,
                              ).withFont(
                                fontFamily: AppFonts.lato,
                                fontWeight: AppFonts.regular,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
