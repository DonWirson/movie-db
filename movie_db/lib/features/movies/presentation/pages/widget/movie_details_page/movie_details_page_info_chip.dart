import 'package:flutter/material.dart';

class MovieDetailsPageInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const MovieDetailsPageInfoChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white54, size: 16),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}
