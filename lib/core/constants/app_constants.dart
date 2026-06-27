import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF5B3DF5);
  static const Color backgroundColor = Color(0xFFF7F8FC);
  static const Color cardColor = Colors.white;
  static const Color darkSidebarColor = Color(0xFF151D3B); // Navy blue for the right sidebar
  static const Color textDarkColor = Color(0xFF1B254B);
  static const Color textLightColor = Color(0xFFA3AED0);
  static const Color iconColor = Color(0xFF8F9BBA);
  static const Color projectRed = Color(0xFFE31A1A);
  static const Color projectBlue = Color(0xFF1A3EE3);

  // Spacing & Radius
  static const double defaultPadding = 16.0;
  static const double borderRadius = 20.0;

  // Shadows
  static List<BoxShadow> softShadows = [
    BoxShadow(
      color: const Color(0xFF7090B0).withOpacity(0.14),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

  // Dummy Avatars (Using reliable and premium Unsplash photos)
  static const String poojaAvatar = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=150&auto=format&fit=crop';
  static const String avatar1 = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop';
  static const String avatar2 = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop';
  static const String avatar3 = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=150&auto=format&fit=crop';
  static const String avatar4 = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=150&auto=format&fit=crop';
  static const String avatar5 = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=150&auto=format&fit=crop';
  static const String avatar6 = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=150&auto=format&fit=crop';
}
