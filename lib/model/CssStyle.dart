// import 'package:flutter/material.dart';

// class CssStyle{

//     /// CSS attribute "`background-color`"
//     /// 
//     /// 기본값: Colors.transparent
//     Color? backgroundColor;

//     /// CSS attribute "`color`"
//     /// 
//     /// 기본값: unspecified,
//     Color? color;

//     /// CSS attribute "`direction`"
//     /// 
//     /// 기본값: TextDirection.ltr,
//     TextDirection? direction;

//     /// CSS attribute "`display`"
//     /// 
//     /// 기본값: unspecified,
//     Display? display;

//     /// CSS attribute "`font-family`"
//     /// 
//     /// 기본값: Theme.of(context).style.textTheme.body1.fontFamily
//     String? fontFamily;

//     // /// The list of font families to fall back on when a glyph cannot be found in default font family.
//     // ///
//     // /// 기본값: null
//     // List<String>? fontFamilyFallback;

//     // /// CSS attribute "`font-feature-settings`"
//     // ///
//     // /// 기본값: normal
//     // List<FontFeature>? fontFeatureSettings;

//     /// CSS attribute "`font-size`"
//     ///
//     /// 기본값: FontSize.medium
//     double? fontSize;
  
//     /// CSS attribute "`font-style`"
//     ///
//     /// 기본값: FontStyle.normal,
//     FontStyle? fontStyle;

//     /// CSS attribute "`font-weight`"
//     ///
//     /// Inherited: yes,
//     /// Default: FontWeight.normal,
//     FontWeight? fontWeight;

//     /// CSS attribute "`height`"
//     ///
//     /// Default: Height.auto(),
//     Height? height;

//     /// CSS attribute "`letter-spacing`"
//     ///
//     /// Default: normal (0),
//     double? letterSpacing;

//     /// CSS attribute "`padding`"
//     ///
//     /// Default: EdgeInsets.zero
//     EdgeInsets? padding;

//     /// CSS pseudo-element "`::marker`"
//     ///
//     /// Inherited: no,
//     /// Default: null
//     Marker? marker;

//     /// CSS attribute "`margin`"
//     ///
//     /// Inherited: no,
//     /// Default: EdgeInsets.zero
//     Margins? margin;

//     /// CSS attribute "`text-align`"
//     ///
//     /// Inherited: yes,
//     /// Default: TextAlign.start,
//     TextAlign? textAlign;

//     /// CSS attribute "`text-decoration`"
//     ///
//     /// Inherited: no,
//     /// Default: TextDecoration.none,
//     TextDecoration? textDecoration;

//     /// CSS attribute "`text-decoration-color`"
//     ///
//     /// Default: Current color
//     Color? textDecorationColor;

//     /// CSS attribute "`text-decoration-style`"
//     ///
//     /// Inherited: no,
//     /// Default: TextDecorationStyle.solid,
//     TextDecorationStyle? textDecorationStyle;

//     /// Loosely based on CSS attribute "`text-decoration-thickness`"
//     ///
//     /// Uses a percent modifier based on the font size.
//     ///
//     /// Inherited: no,
//     /// Default: 1.0 (specified by font size)
//     // TODO(Sub6Resources): Possibly base this more closely on the CSS attribute.
//     double? textDecorationThickness;

//     /// CSS attribute "`text-shadow`"
//     ///
//     /// Inherited: yes,
//     /// Default: none,
//     List<Shadow>? textShadow;

//     /// CSS attribute "`vertical-align`"
//     ///
//     /// Inherited: no,
//     /// Default: VerticalAlign.BASELINE,
//     VerticalAlign? verticalAlign;

//     /// CSS attribute "`white-space`"
//     ///
//     /// Inherited: yes,
//     /// Default: WhiteSpace.NORMAL,
//     WhiteSpace? whiteSpace;

//     /// CSS attribute "`width`"
//     ///
//     /// Inherited: no,
//     /// Default: Width.auto()
//     Width? width;

//     /// CSS attribute "`word-spacing`"
//     ///
//     /// Inherited: yes,
//     /// Default: normal (0)
//     double? wordSpacing;

//     /// CSS attribute "`line-height`"
//     ///
//     /// Supported values: double values
//     ///
//     /// Unsupported values: normal, 80%, ..
//     ///
//     /// Inherited: no,
//     /// Default: Unspecified (null),
//     LineHeight? lineHeight;

//     //TODO modify these to match CSS styles
//     String? before;
//     String? after;
//     Border? border;
//     Alignment? alignment;
//     Widget? markerContent;



// }


// /// CSS attribute "`display`"
// enum Display {
//   block,
//   inline,
//   inlineBlock,
//   listItem,
//   none,
// }