import 'dart:async';

import 'package:flutter/material.dart';

class FlutterMadaMainCountController extends StatefulWidget {
  const FlutterMadaMainCountController({
    super.key,
    required this.decrementIconBuilder,
    required this.incrementIconBuilder,
    this.performApi,
    required this.countBuilder,
    required this.count,
    required this.updateCount,
    this.stepSize = 1,
    this.minimum,
    this.maximum,
    this.isLoading,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 25.0),
  });

  final Widget Function(bool enabled) decrementIconBuilder;
  final Widget Function(bool enabled) incrementIconBuilder;
  final void Function()? performApi;
  final Widget Function(int count) countBuilder;
  final int count;
  final Function(int)? updateCount;
  final int stepSize;
  final int? minimum;
  final int? maximum;
  final bool? isLoading;
  final EdgeInsetsGeometry contentPadding;

  @override
  _FlutterFlowMainCountControllerState createState() =>
      _FlutterFlowMainCountControllerState();
}

class _FlutterFlowMainCountControllerState
    extends State<FlutterMadaMainCountController> {

  int get count => widget.count;

  int? get minimum => widget.minimum;

  int? get maximum => widget.maximum;

  int get stepSize => widget.stepSize;

  bool get canDecrement => minimum == null || count - stepSize >= minimum!;

  bool get canIncrement => maximum == null || count + stepSize <= maximum!;
  Timer? _debounce;

  void _decrementCounter() async {
    if (widget.isLoading == true) return; // Prevent action if loading
    if (canDecrement) {
      setState(() => widget.updateCount!(count - stepSize));
    }

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 200), () {
      preformApi();
    });
  }

  void preformApi() {
    if (widget.isLoading == true) return; // Prevent API call if loading
    widget.performApi?.call();
  }

  void _incrementCounter() async {
    if (widget.isLoading == true) return; // Prevent action if loading
    if (canIncrement) {
      setState(() => widget.updateCount!(count + stepSize));
    }

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 200), () {
      preformApi();
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: widget.contentPadding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: widget.isLoading != true ? _decrementCounter : null, // Disable decrement when loading
          child: widget.decrementIconBuilder(canDecrement),
        ),
        widget.countBuilder(count),
        InkWell(
          onTap: widget.isLoading != true ? _incrementCounter : null, // Disable increment when loading
          child: widget.incrementIconBuilder(canIncrement),
        ),
      ],
    ),
  );
}
