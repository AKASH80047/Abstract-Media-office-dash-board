import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isSmall = width < 600;

        return Container(
          height: isSmall ? 230 : 270,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF3A1C94),
                Color(0xFF5B3DF5),
                Color(0xFF9E00FF),
                Color(0xFFFF007A),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5B3DF5).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: Stack(
              children: [
                // Animated Floating Background Shapes
                if (!isSmall) ...[
                  // Black Torus (Donut)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        right: width * 0.28,
                        top: 20 + (_controller.value * 12),
                        child: Transform.rotate(
                          angle: _controller.value * 0.15,
                          child: const Custom3DShape(shapeType: ShapeType.torus),
                        ),
                      );
                    },
                  ),
                  // Blue Capsule
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        right: width * 0.18,
                        top: 70 - (_controller.value * 15),
                        child: Transform.rotate(
                          angle: -math.pi / 4 + (_controller.value * 0.1),
                          child: const Custom3DShape(shapeType: ShapeType.capsule),
                        ),
                      );
                    },
                  ),
                  // Purple Pyramid
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        right: width * 0.08,
                        top: 40 + (_controller.value * 18),
                        child: Transform.rotate(
                          angle: _controller.value * 0.2,
                          child: const Custom3DShape(shapeType: ShapeType.pyramid),
                        ),
                      );
                    },
                  ),
                  // White Cube
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        right: width * 0.01,
                        top: 110 - (_controller.value * 10),
                        child: Transform.rotate(
                          angle: math.pi / 6 + (_controller.value * 0.15),
                          child: const Custom3DShape(shapeType: ShapeType.cube),
                        ),
                      );
                    },
                  ),
                  // Turquoise Sphere
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        right: width * 0.12,
                        top: 160 + (_controller.value * 14),
                        child: const Custom3DShape(shapeType: ShapeType.sphere),
                      );
                    },
                  ),
                ],

                // Content Overlay
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 20.0 : 32.0,
                    vertical: isSmall ? 16.0 : 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ETHEREUM 2.0',
                        style: TextStyle(
                          color: Color(0xFFE0D8FF),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Top Rating\nProject',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: isSmall ? 24 : 32,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Trending project and high rating\nProject Created by team.',
                        style: TextStyle(
                          color: const Color(0xFFF3EFFF).withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                          fontSize: isSmall ? 11 : 13,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF111A3E), // Dark button
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Learn More.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum ShapeType { torus, capsule, pyramid, cube, sphere }

class Custom3DShape extends StatelessWidget {
  final ShapeType shapeType;

  const Custom3DShape({super.key, required this.shapeType});

  @override
  Widget build(BuildContext context) {
    switch (shapeType) {
      case ShapeType.torus:
        return CustomPaint(
          size: const Size(60, 60),
          painter: TorusPainter(),
        );
      case ShapeType.capsule:
        return Container(
          width: 25,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF0047FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0047FF).withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(3, 5),
              ),
            ],
          ),
        );
      case ShapeType.pyramid:
        return CustomPaint(
          size: const Size(60, 60),
          painter: PyramidPainter(),
        );
      case ShapeType.cube:
        return CustomPaint(
          size: const Size(50, 50),
          painter: CubePainter(),
        );
      case ShapeType.sphere:
        return Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF00FFD1), Color(0xFF007A65)],
              center: Alignment(-0.3, -0.3),
              radius: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF007A65).withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
        );
    }
  }
}

// 3D Painters

class TorusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double radius = size.width * 0.35;

    // Draw dark torus body
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF1E1E24),
          Color(0xFF3A3A45),
          Color(0xFF111115),
          Color(0xFF1E1E24),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius));

    canvas.drawCircle(Offset(cx, cy), radius, paint);

    // Highlight overlay for glossy reflection
    final Paint highlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = LinearGradient(
        colors: [Colors.white.withOpacity(0.4), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius));

    canvas.drawCircle(Offset(cx, cy), radius - 4, highlight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PyramidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path1 = Path();
    final Path path2 = Path();
    
    // Front-left face of the pyramid
    path1.moveTo(size.width / 2, 5); // peak
    path1.lineTo(5, size.height - 10); // bottom-left
    path1.lineTo(size.width / 2, size.height - 5); // bottom-center
    path1.close();

    // Front-right face of the pyramid
    path2.moveTo(size.width / 2, 5); // peak
    path2.lineTo(size.width / 2, size.height - 5); // bottom-center
    path2.lineTo(size.width - 5, size.height - 15); // bottom-right
    path2.close();

    final Paint paint1 = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFD43CFF), Color(0xFF6B008F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final Paint paint2 = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF9E00FF), Color(0xFF3F0066)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Top face
    final Path topFace = Path()
      ..moveTo(w / 2, 5)
      ..lineTo(w - 5, h * 0.3)
      ..lineTo(w / 2, h * 0.55)
      ..lineTo(5, h * 0.3)
      ..close();

    // Left face
    final Path leftFace = Path()
      ..moveTo(5, h * 0.3)
      ..lineTo(w / 2, h * 0.55)
      ..lineTo(w / 2, h - 5)
      ..lineTo(5, h * 0.7)
      ..close();

    // Right face
    final Path rightFace = Path()
      ..moveTo(w / 2, h * 0.55)
      ..lineTo(w - 5, h * 0.3)
      ..lineTo(w - 5, h * 0.7)
      ..lineTo(w / 2, h - 5)
      ..close();

    final Paint topPaint = Paint()..color = Colors.white;
    final Paint leftPaint = Paint()..color = Colors.grey[300]!;
    final Paint rightPaint = Paint()..color = Colors.grey[400]!;

    canvas.drawPath(topFace, topPaint);
    canvas.drawPath(leftFace, leftPaint);
    canvas.drawPath(rightFace, rightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
