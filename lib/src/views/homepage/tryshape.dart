import 'package:flutter/material.dart';

class TryShapeWithCustomPaint extends StatefulWidget {
  const TryShapeWithCustomPaint({super.key});

  @override
  State<TryShapeWithCustomPaint> createState() =>
      _TryShapeWithCustomPaintState();
}

class _TryShapeWithCustomPaintState extends State<TryShapeWithCustomPaint> {
  bool isDown = false;
  double x = 0.0;
  double y = 0.0;
  int? targetId;
  Map<int, Map<String, double>> pathList = {
    1: {"x": 100, "y": 100, "r": 50, "color": 0},
    2: {"x": 200, "y": 200, "r": 50, "color": 1},
    3: {"x": 300, "y": 300, "r": 50, "color": 2},
  };

  // util function
  bool isInObject(Map<String, double> data, double dx, double dy) {
    Path _tempPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(data['x']!, data['y']!), radius: data['r']!));
    return _tempPath.contains(Offset(dx, dy));
  }

// event handler
  void _down(DragStartDetails details) {
    setState(() {
      isDown = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;
    });
  }

  void _up() {
    setState(() {
      isDown = false;
      targetId = null;
    });
  }

  void _move(DragUpdateDetails details) {
    if (isDown) {
      setState(() {
        x += details.delta.dx;
        y += details.delta.dy;
        targetId ??=
            pathList.keys.firstWhere((_id) => isInObject(pathList[_id]!, x, y));
        if (targetId != null) {
          pathList = {
            ...pathList,
            targetId!: {...pathList[targetId!]!, 'x': x, 'y': y}
          };
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          _down(details);
        },
        onPanEnd: (details) {
          _up();
        },
        onPanUpdate: (details) {
          _move(details);
        },
        child: Center(
          child: Container(
              width: 300,
              height: 300,
              color: Colors.white,
              child: CustomPaint(foregroundPainter: LinearPainter()
                  // ShapePainter(down: isDown, x: x, y: y, pathList: pathList),

                  )),
        ),
      ),
    );
  }
}

class LinearPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawLine(Offset(size.width * 1 / 6, size.height * 1 / 2),
        Offset(size.width * 5 / 6, size.height * 1 / 2), paint);
    canvas.drawCircle(
        Offset(size.width * 1 / 2, size.height * 1 / 2),
        120,
        Paint()
          ..strokeJoin = StrokeJoin.bevel
          ..color = Colors.black26);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ShapePainter extends CustomPainter {
  final colors = [Colors.red, Colors.yellow, Colors.lightBlue];
  Path path = Path();
  Paint _paint = Paint()
    ..color = Colors.red
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.round;

  final bool down;
  final double x;
  final double y;
  Map<int, Map<String, double>> pathList;
  ShapePainter({
    required this.down,
    required this.x,
    required this.y,
    required this.pathList,
  });
  @override
  void paint(Canvas canvas, Size size) {
    for (var pathData in pathList.values) {
      _paint = _paint..color = colors[pathData['color']! as int];
      path = Path()
        ..addOval(Rect.fromCircle(
            center: Offset(pathData['x']!, pathData['y']!),
            radius: pathData['r']!));
      canvas.drawPath(path, _paint);
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) => down;
}
