import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildImage(
    dynamic icon, {
      double width = 20.0,
      double height = 20.0,
      Color? color,
      BoxFit fit = BoxFit.cover,
    }) {
  // Handle IconData (Flutter's built-in icons)
  if (icon is IconData) {
    return Icon(
      icon,
      color: color ?? Colors.white, // Default to white if no color is provided
      size: width,  // Use width as the size for the icon
    );
  }

  // Handle SvgPicture (direct SVG widget)
  else if (icon is SvgPicture) {
    return icon;
  }

  // Handle String (for SVG asset path, network URL, or PNG)
  else if (icon is String) {
    if (icon.endsWith('.svg')) {
      return SvgPicture.asset(
        icon,
        color: color ?? null,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // If it's a valid network URL
    else if (_isValidUrl(icon)) {
      return Image.network(
        icon,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // Handle PNG or other image assets (local assets)
    else if (icon.endsWith('.png')) {
      return Image.asset(
        icon,
        color: color ?? null, // Color is optional for PNG
        width: width,
        height: height,
        fit: fit,
      );
    }

    // Fallback if the type doesn't match expected formats
    else {
      return Icon(Icons.broken_image, color: color ?? null, size: width);
    }
  }

  // Default fallback for unsupported icon types
  else {
    return SizedBox.shrink();
  }
}

// Helper function to validate URLs (checks for http:// or https://)
bool _isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return false;
  return uri.isScheme('http') || uri.isScheme('https');
}
