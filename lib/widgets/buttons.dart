import 'package:flutter/material.dart';

class AppButtons {
  /// Premium uniform button used across all screens
  static Widget primaryButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool isSmall = false,
  }) {
    return _baseButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      isSmall: isSmall,
      background: Colors.blue.shade700,     // SAME COLOR
      foreground: Colors.white,
      shadow: Colors.blue.shade700.withOpacity(0.3),
    );
  }

  static Widget secondaryButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    bool isSmall = false,
  }) {
    return _baseButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      isSmall: isSmall,
      background: Colors.grey.shade200,     // SAME COLOR
      foreground: Colors.grey.shade800,
      shadow: Colors.grey.withOpacity(0.3),
    );
  }

  /// Base widget used internally
  static Widget _baseButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    required Color background,
    required Color foreground,
    required Color shadow,
    required bool isSmall,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: isSmall ? 16 : 20),
        label: Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 12 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          minimumSize: Size(double.infinity, isSmall ? 40 : 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 8 : 16,
            vertical: isSmall ? 8 : 12,
          ),
        ),
      ),
    );
  }
}
