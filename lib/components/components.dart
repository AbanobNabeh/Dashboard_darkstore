import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

Widget defText({
  required String text,
  double size = 20,
  FontWeight fontWeight = FontWeight.bold,
  TextDecoration decoration = TextDecoration.none,
  Color decorationColor = Colors.black,
  Color color = Colors.white,
  int? maxlines,
  TextOverflow? overflow,
}) =>
    Text(
      text.tr,
      maxLines: maxlines,
      overflow: overflow,
      style: GoogleFonts.cairo(
        textStyle: TextStyle(fontSize: size, color: color),
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: TextDecorationStyle.wavy,
      ),
    );

Widget defTextForm({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required String hint,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function()? ontapPre,
  Function()? ontapSuff,
  FocusNode? focusNode,
  Function(String)? onchange,
  void Function()? ontap,
  bool obscureText = false,
  Color hintcolor = Colors.white,
  FontWeight fontWeight = FontWeight.bold,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
  int maxLines = 1,
  List<TextInputFormatter>? inputFormatters,
}) =>
    Container(
      width: 350,
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        obscureText: obscureText,
        onTap: ontap,
        onChanged: onchange,
        focusNode: focusNode,
        textDirection: trans() == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        controller: controller,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(
              color: hintcolor,
              fontWeight: fontWeight,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: defcolor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: defcolor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            fillColor: defcolor,
            filled: true,
            prefixIcon: prefixIcon == null
                ? null
                : IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: ontapPre,
                    icon: Icon(
                      prefixIcon,
                      color: Colors.white,
                    ),
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: ontapSuff,
                    icon: Icon(
                      suffixIcon,
                      color: Colors.white,
                    ),
                  ),
            hintText: hint.tr),
      ),
    );

Widget defbutton(
        {bool boxshade = true,
        Color backgroundcolor = Colors.white,
        double radius = 10,
        double width = double.infinity,
        required String text,
        Color? colors,
        required Function()? tap}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxshade == false
            ? null
            : [
                BoxShadow(
                  color: Colors.grey[900]!,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(3, 4),
                ),
              ],
      ),
      child: MaterialButton(
        onPressed: tap,
        child: defText(
            text: text, size: 20, color: colors == null ? defcolor : colors),
      ),
    );

Widget defcirculer({Color colors = Colors.white}) => Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        color: defcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: CircularProgressIndicator(
        color: colors,
      )),
    );

Widget defprice(
        {required int discount,
        required int price,
        required String finalprice}) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: discount == 0
            ? defText(text: "${price} \$", size: 16)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  defText(
                    text: "$finalprice \$",
                    size: 18,
                  ),
                  defText(
                    text: "${price}",
                    decoration: TextDecoration.lineThrough,
                    size: 12,
                    color: Colors.red,
                  )
                ],
              ),
      ),
    );

Widget defborder(
        {required Widget child,
        double width = 80,
        double height = 80,
        double radius = 15}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: defcolor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: defgraycolor, width: 2.5),
      ),
      child: child,
    );
