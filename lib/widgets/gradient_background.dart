import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Latar belakang gradient ungu + lingkaran dekoratif.
/// Bungkus setiap halaman: GradientBackground(child: Scaffold(...))
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.bgTop,
                  AppColors.bgMid,
                  AppColors.bgBottom,
                ],
              ),
            ),
          ),
        ),
        Positioned(top: -90, right: -70, child: _blob(240, 0.22)),
        Positioned(bottom: -110, left: -90, child: _blob(280, 0.16)),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget _blob(double size, double alpha) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.accent.withValues(alpha: alpha),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

/// Kartu semi-transparan (efek kaca) untuk isi halaman.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double radius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(radius);
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.09),
          borderRadius: shape,
          border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        ),
        child: InkWell(
          borderRadius: shape,
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}