import 'package:url_launcher/url_launcher.dart';

import '../general_exports.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
    double longitude,
    double latitude, {
    bool useGoogleUrl = false,
  }) async {
    final String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(
        Uri.parse(googleUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not open the map.';
    }
  }
}

class WidgetToMarker extends StatelessWidget {
  const WidgetToMarker({
    required this.text,
    super.key,
    this.image,
  });

  final String text;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(AppColors.green),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomRight: isRTL ? const Radius.circular(10) : Radius.zero,
                  bottomLeft: isRTL ? Radius.zero : const Radius.circular(10),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 3),
        //   decoration: (image == null || image!.isEmpty)
        //       ? null
        //       : BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(
        //             color: Color(AppColors.green).withOpacity(0.4),
        //             width: 6,
        //           ),
        //         ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(40),
        //     child: (image == null || image!.isEmpty)
        //         ? Image.asset(
        //             imageMadaMarker,
        //             width: 40,
        //             height: 40,
        //           )
        //         : CachedImage(
        //             image: image,
        //             width: 40,
        //             height: 40,
        //           ),
        //   ),
        // )
      ],
    );
  }
}

class WidgetToExclusiveMarker extends StatelessWidget {
  const WidgetToExclusiveMarker({
    required this.text,
    required this.developerName,
    super.key,
    this.image,
  });

  final String text;
  final String developerName;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(AppColors.black),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomRight: isRTL ? const Radius.circular(15) : Radius.zero,
                  bottomLeft: isRTL ? Radius.zero : const Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: (image == null || image!.isEmpty)
                  //       ? Image.asset(
                  //           imageMadaMarker,
                  //           width: 40,
                  //           height: 40,
                  //         )
                  //       : CachedImage(
                  //           image: image,
                  //           width: 40,
                  //           height: 40,
                  //         ),
                  // ),
                  // SizedBox(width: DEVICE_WIDTH * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   developerName,
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
