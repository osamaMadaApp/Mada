import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.value) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      widget.value ? _animationController.forward() : _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.value) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 55.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: _circleAnimation.value,
                child: Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
