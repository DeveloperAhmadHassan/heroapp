import 'dart:math' as math;

import 'package:flutter/material.dart';

class HollowCircularProgressBar extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final List<Color> backgroundGradientColors;
  final List<double>? gradientStops;
  final double progress;
  final Color knobColor;
  final double knobRadius;
  final ValueChanged<double>? onChanged;

  const HollowCircularProgressBar({
    super.key,
    required this.size,
    required this.strokeWidth,
    this.backgroundGradientColors = const [
      Color(0xFFC9BBEF),
      Color(0xFFF28DB3),
      Color(0xFFF99955),
      Color(0xFF6EB9AD),
    ],
    this.gradientStops,
    required this.progress,
    this.knobColor = Colors.white,
    this.knobRadius = 12.0,
    this.onChanged
  });

  @override
  State<HollowCircularProgressBar> createState() => _HollowCircularProgressBarState();
}

class _HollowCircularProgressBarState extends State<HollowCircularProgressBar> {
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress.clamp(0.0, 1.0);
  }

  double _positionToProgress(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = position - center;
    double angle = math.atan2(delta.dy, delta.dx);
    angle = angle - (-math.pi / 2);
    if (angle < 0) angle += 2 * math.pi;
    double progress = angle / (2 * math.pi);
    return progress.clamp(0.0, 1.0);
  }

  void _updateProgress(Offset position, Size size) {
    final newProgress = _positionToProgress(position, size);
    if (newProgress != _progress) {
      setState(() {
        _progress = newProgress;
      });
      widget.onChanged?.call(_progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
              onPanUpdate: (details) {
                final renderBox = context.findRenderObject() as RenderBox;
                final localPosition = renderBox.globalToLocal(details.globalPosition);
                final size = constraints.biggest;
                if (size.width > 0 && size.height > 0) {
                  _updateProgress(localPosition, size);
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: CustomPaint(
                      painter: _HollowGradientRingPainter(
                        strokeWidth: widget.strokeWidth,
                        gradientColors: widget.backgroundGradientColors,
                        stops: widget.gradientStops,
                        progress: _progress,
                        knobColor: widget.knobColor,
                        knobRadius: widget.knobRadius,
                      ),
                    ),
                  ),
                  if (_progress <= 0.25)
                    Image.asset("assets/moods/mood_calm.png"),

                  if (_progress > 0.25 && _progress <= 0.50)
                    Image.asset("assets/moods/mood_content.png"),

                  if (_progress > 0.50 && _progress <= 0.75)
                    Image.asset("assets/moods/mood_peaceful.png"),

                  if (_progress > 0.75 && _progress <= 1.00)
                    Image.asset("assets/moods/mood_happy.png"),
                ],
              )
          );
        },
      ),
    );
  }
}

class _HollowGradientRingPainter extends CustomPainter {
  final double strokeWidth;
  final List<Color> gradientColors;
  final List<double>? stops;
  final double progress;
  final Color knobColor;
  final double knobRadius;

  _HollowGradientRingPainter({
    required this.strokeWidth,
    required this.gradientColors,
    required this.stops,
    required this.progress,
    required this.knobColor,
    required this.knobRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final double startAngle = -math.pi / 2;
    final double fullCircle = 2 * math.pi;

    final Paint ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final SweepGradient sweepGradient = SweepGradient(
      center: Alignment.center,
      colors: gradientColors,
      stops: stops,
      startAngle: 0.0,
      endAngle: fullCircle,
    );
    ringPaint.shader = sweepGradient.createShader(rect);
    canvas.drawArc(rect, startAngle, fullCircle, false, ringPaint);

    final double knobAngle = startAngle + progress * fullCircle;
    final double radius = size.width / 2;
    final Offset center = rect.center;
    final double distanceFromCenter = radius - strokeWidth / 7;
    final double knobX = center.dx + distanceFromCenter * math.cos(knobAngle);
    final double knobY = center.dy + distanceFromCenter * math.sin(knobAngle);

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withAlpha(40)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
    canvas.drawCircle(Offset(knobX, knobY), knobRadius + 1, shadowPaint);

    final Paint knobPaint = Paint()
      ..color = knobColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawCircle(Offset(knobX, knobY), knobRadius, knobPaint);

    final Paint borderPaint = Paint()
      ..color = Colors.black.withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(Offset(knobX, knobY), knobRadius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _HollowGradientRingPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.stops != stops ||
        oldDelegate.progress != progress ||
        oldDelegate.knobColor != knobColor ||
        oldDelegate.knobRadius != knobRadius;
  }
}
