import 'package:flutter/material.dart';

class MovieDetailsPageCircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MovieDetailsPageCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
