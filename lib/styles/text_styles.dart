import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get detailsTitle => TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.white);
  TextStyle get detLabelGrey => TextStyle(fontWeight: FontWeight.w300, color: Colors.grey);
  TextStyle get detValBlack => TextStyle(fontWeight: FontWeight.w600, color: Colors.black87);
  TextStyle get detTableLab => TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6);
  TextStyle get detToggleContent => TextStyle(fontSize: 14, color: Colors.black.withAlpha(180));
}