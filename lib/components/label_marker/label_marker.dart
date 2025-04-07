/// A widget to create markers with text label on Google Maps
library;

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../general_exports.dart';

extension AddExtension on Set<Marker> {
  /// Add a LabelMarker to existing set of Markers
  ///
  /// * Pass the [LabelMarker] object to add to the set
  /// * !!! IMPORTANT!!!
  /// *   Call setstate after calling this function, as shown in the example
  ///
  /// Example
  ///
  ///       markers.addLabelMarker(LabelMarker(
  ///         label: "makerLabel",
  ///         markerId: MarkerId("markerIdString"),
  ///         position: LatLng(11.1203, 45.33),),
  ///       ).then((_) {
  ///          setState(() {});
  ///      });
  Future<bool> addLabelMarker(LabelMarker labelMarker) async {
    bool result = false;
    await createCustomMarkerBitmap(
      labelMarker.label,
      backgroundColor: labelMarker.backgroundColor,
      borderColor: labelMarker.borderColor,
      textStyle: labelMarker.textStyle,
    ).then(
      (value) {
        add(Marker(
            markerId: labelMarker.markerId,
            position: labelMarker.position,
            icon: value,
            alpha: labelMarker.alpha,
            anchor: labelMarker.anchor,
            consumeTapEvents: labelMarker.consumeTapEvents,
            draggable: labelMarker.draggable,
            flat: labelMarker.flat,
            infoWindow: labelMarker.infoWindow,
            rotation: labelMarker.rotation,
            visible: labelMarker.visible,
            zIndex: labelMarker.zIndex,
            onTap: labelMarker.onTap,
            onDragStart: labelMarker.onDragStart,
            onDrag: labelMarker.onDrag,
            onDragEnd: labelMarker.onDragEnd));
        result = true;
      },
    );
    return (result);
  }
}

Future<BitmapDescriptor> createCustomMarkerBitmap(
  String title, {
  required TextStyle textStyle,
  Color? backgroundColor,
  Color? borderColor,
}) async {
  // Adjust the font size in the TextStyle
  final TextSpan span = TextSpan(
    style: textStyle.copyWith(fontSize: 24.0), // Slightly increased font size
    text: title,
  );
  final TextPainter painter = TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
  );
  painter.layout();

  final int textWidth = painter.width.toInt();
  final int textHeight = painter.height.toInt();

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  // Define the border paint with the same stroke width for both container and arrow
  final Paint containerBorderPaint = Paint()
    ..color = borderColor ?? Colors.white
    ..style = PaintingStyle.fill
    ..strokeWidth = 3; // Adjusted stroke width for slightly larger size

  final Paint arrowBorderPaint = Paint()
    ..color = borderColor ?? Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6; // Adjusted stroke width for slightly larger size

  // Draw the white border for the main container (card background)
  canvas.drawRRect(
    RRect.fromLTRBAndCorners(
      0,
      0,
      textWidth + 80, // Increased width
      textHeight + 60, // Increased height
      bottomLeft: const Radius.circular(20), // Increased border radius
      bottomRight: const Radius.circular(20),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
    ),
    containerBorderPaint,
  );

  // Draw the background color of the card
  canvas.drawRRect(
    RRect.fromLTRBAndCorners(
      4, // Adjusted to leave space for border
      4,
      textWidth + 76,
      textHeight + 56,
      bottomLeft: const Radius.circular(18),
      bottomRight: const Radius.circular(18),
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
    ),
    Paint()..color = backgroundColor ?? const Color(AppColors.gray),
  );

  // Draw the arrow border (left and right sides only)
  final arrowBorderPath = Path();
  arrowBorderPath.moveTo(60, textHeight + 56); // Adjusted for larger size
  arrowBorderPath.lineTo(80, textHeight + 80); // Adjusted for larger size
  arrowBorderPath.moveTo(80, textHeight + 80);
  arrowBorderPath.lineTo(100, textHeight + 56); // Adjusted for larger size
  canvas.drawPath(
    arrowBorderPath,
    arrowBorderPaint,
  );

  // Draw the arrow background
  final arrowPath = Path();
  arrowPath.moveTo(60, textHeight + 56); // Adjusted for larger size
  arrowPath.lineTo(80, textHeight + 80); // Adjusted for larger size
  arrowPath.lineTo(100, textHeight + 56); // Adjusted for larger size
  arrowPath.close();
  canvas.drawPath(
    arrowPath,
    Paint()
      ..color = backgroundColor ?? const Color(AppColors.gray)
      ..style = PaintingStyle.fill,
  );

  // Draw the text
  painter.paint(
      canvas, const Offset(40.0, 25.0)); // Adjusted offset for larger size

  // Convert to BitmapDescriptor
  final ui.Picture picture = pictureRecorder.endRecording();
  final ByteData? pngBytes = await (await picture.toImage(
    textWidth + 80, // Increased width
    textHeight + 100, // Increased height
  ))
      .toByteData(format: ui.ImageByteFormat.png);
  final Uint8List data = Uint8List.view(pngBytes!.buffer);
  return BitmapDescriptor.fromBytes(data);
}

class LabelMarker {
  /// Creates a marker with text label
  ///
  /// * Pass the [label] to be displayed on the marker
  /// * Pass the [markerId] to be used as a key for the marker
  /// * Pass the [position] to be used as the marker's position
  /// * Optionally pass the [backgroundColor] to be used as the marker's background color
  /// * Optionally pass the [borderColor] to be used as the marker's border color
  /// * Optionally pass the [textStyle] to be used as the marker's text style
  /// * Optionally you could pass all the other parameters passed for a normal marker
  ///
  LabelMarker({
    required this.label,
    required this.markerId,
    required this.position,
    this.backgroundColor,
    this.borderColor,
    this.textStyle = const TextStyle(
      fontSize: 27.0,
      color: Colors.white,
      letterSpacing: 1.0,
      fontFamily: 'Roboto Bold',
    ),
    this.alpha = 1.0,
    this.anchor = const Offset(0.5, 1.0),
    this.consumeTapEvents = false,
    this.draggable = false,
    this.flat = false,
    this.icon = BitmapDescriptor.defaultMarker,
    this.infoWindow = InfoWindow.noText,
    this.rotation = 0.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.onTap,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
  });

  /// The text to be displayed on the marker
  final String label;

  /// Uniquely identifies a [Marker].
  final MarkerId markerId;

  /// Geographical location of the marker.
  final LatLng position;

  /// Background color of the label marker.
  final Color? backgroundColor;

  /// Border color of the label marker.
  final Color? borderColor;

  /// TextStyle for the text to be displayed in the label marker.
  final TextStyle textStyle;

  /// The opacity of the marker, between 0.0 and 1.0 inclusive.
  ///
  /// 0.0 means fully transparent, 1.0 means fully opaque.
  final double alpha;

  /// The icon image point that will be placed at the [position] of the marker.
  ///
  /// The image point is specified in normalized coordinates: An anchor of
  /// (0.0, 0.0) means the top left corner of the image. An anchor
  /// of (1.0, 1.0) means the bottom right corner of the image.
  final Offset anchor;

  /// True if the marker icon consumes tap events. If not, the map will perform
  /// default tap handling by centering the map on the marker and displaying its
  /// info window.
  final bool consumeTapEvents;

  /// True if the marker is draggable by user touch events.
  final bool draggable;

  /// True if the marker is rendered flatly against the surface of the Earth, so
  /// that it will rotate and tilt along with map camera movements.
  final bool flat;

  /// A description of the bitmap used to draw the marker icon.
  final BitmapDescriptor icon;

  /// A Google Maps InfoWindow.
  ///
  /// The window is displayed when the marker is tapped.
  final InfoWindow infoWindow;

  /// Rotation of the marker image in degrees clockwise from the [anchor] point.
  final double rotation;

  /// True if the marker is visible.
  final bool visible;

  /// The z-index of the marker, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final double zIndex;

  /// Callbacks to receive tap events for markers placed on this map.
  final VoidCallback? onTap;

  /// Signature reporting the new [LatLng] at the start of a drag event.
  final ValueChanged<LatLng>? onDragStart;

  /// Signature reporting the new [LatLng] at the end of a drag event.
  final ValueChanged<LatLng>? onDragEnd;

  /// Signature reporting the new [LatLng] during the drag event.
  final ValueChanged<LatLng>? onDrag;
}
