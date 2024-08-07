import 'package:flutter/material.dart';

class GlowingText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color glowColor;

  const GlowingText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          // Glow effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: glowColor.withOpacity(0.5),
                shadows: [
                  Shadow(
                    blurRadius: 30,
                    color: glowColor,
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 30,
                    color: glowColor,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Main text
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
