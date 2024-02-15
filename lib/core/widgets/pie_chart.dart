// ignore_for_file: avoid_classes_with_only_static_members, avoid_setters_without_getters, constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/container_with_border.dart';

class PieChart extends StatelessWidget {
  const PieChart({
    Key? key,
    required this.colors,
    required this.height,
    required this.valueList,
    this.centerCircle,
    this.sameStroke,
  }) : super(key: key);
  final List<double> valueList;
  final List<Color> colors;
  final double height;
  final bool? centerCircle;
  final bool? sameStroke;
  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      borderRadius: 1000,
      /* boxShadow: [
        BoxShadow(blurRadius: 800, color: LoopsColors.colorBlack.withOpacity(0.3))
      ], */
      boxColor: Colors.transparent,
      // padding: EdgeInsets.all(21.sp),
      child: Stack(
        children: [
          SizedBox.shrink(
            child: DropdownButtonFormField<String>(
                onChanged: (value) {}, items: const []),
          ),
          CustomPaint(
            painter: FaceOutlinePainter(
              valueList,
              colors,
              height,
              centerCircle: centerCircle ?? true,
              sameStroke: sameStroke ?? false,
            ),
          ),
        ],
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  FaceOutlinePainter(this.valueList, this.colors, this.height,
      {required this.centerCircle, required this.sameStroke});

  final List<double> valueList;
  final List<Color> colors;
  final double height;
  final bool centerCircle;
  final bool sameStroke;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
    paint.color = const Color.fromARGB(255, 255, 255, 255);
    paint.color = LoopsColors.colorRed;
    paint.strokeWidth = 20;
    paint.style = PaintingStyle.stroke;
    const center = Offset.zero;
    final radius = height;
    _drawArcGroup(
      canvas,
      center: center,
      radius: radius,
      sources: valueList,
      colors: colors,
      paintWidth: 90,
      hasEnd: true,
      curPaintWidth: 30.0,
      curIndex: 1,
      sameStroke: sameStroke,
      centerCircle: centerCircle,
    );
    paint.style = PaintingStyle.fill;
    paint.color = Colors.blue;
    paint.strokeWidth = 2.0;
    paint.isAntiAlias = true;
    paint.color = const Color.fromARGB(255, 255, 255, 255);
    final path = Path();
    if (centerCircle) {
      path.addOval(Rect.fromCircle(center: center, radius: height - 10));
      canvas.drawShadow(path, const Color(0xff000000), 3, true);
      canvas.drawPath(path, paint);
      canvas.save();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}

void _drawArcWithCenter(
  Canvas canvas,
  Paint paint, {
  required Offset center,
  required double radius,
  double startRadian = 0.0,
  double sweepRadian = pi,
  required bool centerCircle,
}) {
  final path = Path();

  path.addOval(Rect.fromCircle(center: center, radius: radius));

  if (centerCircle) {
    canvas.drawShadow(path, const Color.fromARGB(169, 0, 0, 0), 40, true);
  }

  canvas.drawArc(
    Rect.fromCircle(center: center, radius: radius),
    startRadian,
    sweepRadian,
    false,
    paint,
  );
}

void _drawArcGroup(
  Canvas canvas, {
  required Offset center,
  required double radius,
  required List<double> sources,
  required List<Color> colors,
  required bool sameStroke,
  required bool centerCircle,
  double startAngle = 0.0,
  double paintWidth = 10.0,
  bool hasEnd = false,
  bool hasCurrent = false,
  int curIndex = 0,
  double curPaintWidth = 12.0,
}) {
  assert(sources.isNotEmpty);
  assert(colors.isNotEmpty);
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.blue
    ..strokeWidth = paintWidth
    ..isAntiAlias = true;
  double total = 0;
  for (final double d in sources) {
    total += d;
  }
  assert(total > 0.0);
  final List<double> radians = <double>[];
  for (final double d in sources) {
    final double radian = d * 2 * pi / total;
    radians.add(radian);
  }
  var startA = startAngle;
  paint.style = PaintingStyle.stroke;
  var curStartAngle = 0.0;
  for (int i = 0; i < radians.length; i++) {
    final rd = radians[i];
    if (hasCurrent && curIndex == i) {
      curStartAngle = startA;
      startA += rd;
      continue;
    }

    paint.strokeCap = StrokeCap.butt;
    paint.color = colors[i % colors.length];
    paint.strokeWidth =
        sameStroke ? paintWidth : paintWidth * ((i / 2 + 1) / 2);
    _drawArcWithCenter(canvas, paint,
        center: center,
        radius: radius,
        startRadian: startA,
        sweepRadian: rd,
        centerCircle: centerCircle);
    startA += rd;
  }
  if (hasEnd) {
    startA = startAngle;
    paint.strokeWidth = sameStroke ? paintWidth : paintWidth + (curIndex * 2);
    for (int i = 0; i < radians.length; i++) {
      final rd = radians[i];
      if (hasCurrent && curIndex == i) {
        startA += rd;
        continue;
      }
      paint.color = colors[i % colors.length];
      paint.strokeWidth = sameStroke ? paintWidth : paintWidth + (curIndex * 2);
      startA += rd;
    }
  }

  if (hasCurrent) {
    paint.color = colors[curIndex % colors.length];
    paint.strokeWidth =
        sameStroke ? curPaintWidth : curPaintWidth + (curIndex * 2);
    paint.style = PaintingStyle.stroke;
    _drawArcWithCenter(canvas, paint,
        center: center,
        radius: radius,
        startRadian: curStartAngle,
        sweepRadian: radians[curIndex],
        centerCircle: centerCircle);
  }
  if (hasCurrent && hasEnd) {
    // final rd = radians[curIndex % radians.length];
    paint.color = colors[curIndex % colors.length];
    paint.strokeWidth = sameStroke ? curPaintWidth : curPaintWidth * curIndex;
    paint.style = PaintingStyle.fill;
    /*  _drawArcTwoPoint(canvas, paint,
        center: center,
        radius: radius,
        startRadian: curStartAngle,
        sweepRadian: rd,
        hasEndArc: true,
        hasStartArc: true); */
  }
}

class LineCircle {
  ///give the center ,radius of the circle,
  ///and have radian from x clockwise direction.
  ///you can get the point coordinate in the circle.
  static Point radianPoint(Point center, double r, double radian) {
    return Point(center.x + r * cos(radian), center.y + r * sin(radian));
  }
}

class Line {
  ///y = kx + c
  static double normalLine(double x, {double k = 0, double c = 0}) {
    return k * x + c;
  }

  ///Calculate the param K in y = kx +c
  static double paramK(Point p1, Point p2) {
    if (p1.x == p2.x) {
      return 0;
    }
    return (p2.y - p1.y) / (p2.x - p1.x);
  }

  ///Calculate the param C in y = kx +c
  static double paramC(Point p1, Point p2) {
    return p1.y - paramK(p1, p2) * p1.x;
  }
}

/// start point p1, end point p2,p2 is center of the circle,r is its radius.
class LineInterCircle {
  /// start point p1, end point p2,p2 is center of the circle,r is its radius.
  /// param a: y = kx +c intersect with circle,which has the center with point2 and radius R .
  /// when derive to x2+ ax +b = 0 equation. the param a is here.
  static double paramA(Point p1, Point p2) {
    return (2 * Line.paramK(p1, p2) * Line.paramC(p1, p2) -
            2 * Line.paramK(p1, p2) * p2.y -
            2 * p2.x) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  /// start point p1, end point p2,p2 is center of the circle,r is its radius.
  /// param b: y = kx +c intersect with circle,which has the center with point2 and radius R .
  /// when derive to x2+ ax +b = 0 equation. the param b is here.
  static double paramB(Point p1, Point p2, double r) {
    return (p2.x * p2.x -
            r * r +
            (Line.paramC(p1, p2) - p2.y) * (Line.paramC(p1, p2) - p2.y)) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  ///the circle has the intersection or not
  static bool isIntersection(Point p1, Point p2, double r) {
    final delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    return delta >= 0.0;
  }

  ///the x coordinate whether or not is between two point we give.
  static bool _betweenPoint(double x, Point p1, Point p2) {
    if (p1.x > p2.x) {
      return x > p2.x && x < p1.x;
    } else {
      return x > p1.x && x < p2.x;
    }
  }

  static Point _equalX(Point p1, Point p2, double r) {
    if (p1.y > p2.y) {
      return Point(p2.x, p2.y + r);
    } else if (p1.y < p2.y) {
      return Point(p2.x, p2.y - r);
    } else {
      return p2;
    }
  }

  static Point _equalY(Point p1, Point p2, double r) {
    if (p1.x > p2.x) {
      return Point(p2.x + r, p2.y);
    } else if (p1.x < p2.x) {
      return Point(p2.x - r, p2.y);
    } else {
      return p2;
    }
  }

  ///intersection point
  static Point intersectionPoint(Point p1, Point p2, double r) {
    if (p1.x > p2.x - 1 && p1.x < p2.x + 1) {
      return _equalX(p1, p2, r);
    }
    if (p1.y > p2.y - 1 && p1.y < p2.y + 1) {
      return _equalY(p1, p2, r);
    }
    final delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    if (delta < 0.0) {
      //when no intersection, i will return the center of the circ  le.
      return p2;
    }
    final a_2 = -paramA(p1, p2) / 2.0;
    final x1 = a_2 + delta / 2;
    if (_betweenPoint(x1, p1, p2)) {
      final y1 = Line.paramK(p1, p2) * x1 + Line.paramC(p1, p2);
      return Point(x1, y1);
    }
    final x2 = a_2 - delta / 2;
    final y2 = Line.paramK(p1, p2) * x2 + Line.paramC(p1, p2);
    return Point(x2, y2);
  }
}

class SizeKeyConst {
  static const DEVICE_KEY = 'device_size';
  static const ROUND_ANGLE_KEY = 'round_angle_size';
  static const REGULAR_POLYGON_KEY = 'regular_angle_size';
  static const CIRCLE_KEY = 'circle custom painter';
  static const CIRCLE_TRIANGLE_KEY = 'circle triangle painter';
  static const LOGO_KEY = 'logo_page_size';
}

class SizeUtil {
  static final Map<String, SizeUtil> _keyValues = {};

  static void initDesignSize() {
    getInstance(key: SizeKeyConst.ROUND_ANGLE_KEY)?.designSize =
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.REGULAR_POLYGON_KEY)?.designSize =
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.LOGO_KEY)?.designSize =
        const Size(580, 648.0);
    getInstance(key: SizeKeyConst.CIRCLE_KEY)?.designSize =
        const Size(500.0, 500.0);
    getInstance(key: SizeKeyConst.CIRCLE_TRIANGLE_KEY)?.designSize =
        const Size(500.0, 500.0);
  }

  static SizeUtil? getInstance({String key = SizeKeyConst.DEVICE_KEY}) {
    if (_keyValues.containsKey(key)) {
      return _keyValues[key];
    } else {
      _keyValues[key] = SizeUtil();
      return _keyValues[key];
    }
  }

  late Size _designSize;

  set designSize(Size size) {
    _designSize = size;
  }

  //logic size in device
  late Size _logicalSize;

  //device pixel radio.

  double get width => _logicalSize.width;

  double get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  //@param w is the design w;
  double getAxisX(double w) {
    return (w * width) / _designSize.width;
  }

// the y direction
  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  // diagonal direction value with design size s.
  double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}
