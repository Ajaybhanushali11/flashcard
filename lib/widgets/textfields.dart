import 'package:flutter/material.dart';

class AppTextFields {
  /// Premium uniform text field (same UI as your old code)
  static Widget primaryTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required int maxLines,
    FormFieldValidator<String>? validator, // optional
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16,
        ),

        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,

          labelStyle: TextStyle(
            color: Colors.blue.shade700,             // SAME THEME COLOR
            fontWeight: FontWeight.w600,
          ),

          hintStyle: TextStyle(
            color: Colors.grey.shade600,
          ),

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blue.shade700,            // SAME COLOR
              width: 2,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red.shade600,
              width: 2,
            ),
          ),

          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
