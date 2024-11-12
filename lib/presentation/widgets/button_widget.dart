import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final Color? color;
  final double? width;
  final BoxBorder? border;
  final BorderRadius? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool withShadow;
  final bool isActive;

  const ButtonWidget({
    super.key,
    required this.child,
    required this.onTap,
    this.color,
    this.width,
    this.border,
    this.radius,
    this.margin,
    this.padding,
    this.withShadow = true,
    this.isActive = true,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.margin ?? const EdgeInsets.all(0.0),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: widget.radius ??
            const BorderRadius.all(
              Radius.circular(8.0),
            ),
        color: Colors.transparent,
        boxShadow: [
          if (widget.withShadow && widget.isActive)
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Ink(
              width: widget.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF68D8D6), // Start color
                    Color(0xFF4596E0), // End color
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ), // Disabled color
                borderRadius: widget.radius ??
                    const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                border: widget.border,
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                onTap: widget.isActive ? widget.onTap : null,
                child: Padding(
                  padding: widget.padding ??
                      const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                  child: Center(child: widget.child),
                ),
              ),
            ),
            if (!widget.isActive)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: widget.radius ??
                        const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
