// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class textFeildWithBorders extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const textFeildWithBorders({super.key, this.controller, this.onChanged});

  @override
  State<textFeildWithBorders> createState() => _textFeildWithBordersState();
}

class _textFeildWithBordersState extends State<textFeildWithBorders> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6 * fem),
        border: Border.all(color: const Color(0xffeaebed)),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: const InputDecoration(
            focusColor: Colors.yellow,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 1)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class textFeildWithOutBorders extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? icon;
  final bool? obscuretext;
  final ValueChanged<String>? onChanged;

  final String? text;
  final GestureTapCallback? ontap;

  const textFeildWithOutBorders({
    Key? key,
    this.controller,
    this.icon,
    this.obscuretext,
    this.ontap,
    this.onChanged,
    this.text,
  }) : super(key: key);

  @override
  State<textFeildWithOutBorders> createState() =>
      _textFeildWithOutBordersState();
}

class _textFeildWithOutBordersState extends State<textFeildWithOutBorders> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final screenHeight = MediaQuery.of(context).size.height;
    return TextField(
      controller: widget.controller,

      onTap: widget.ontap,
      // validator: validator,
      obscureText: widget.obscuretext ?? false,
      decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
          focusColor: Colors.yellow,
          // errorStyle: const TextStyle(
          //   color: Colors.red,
          //   fontSize: 14.0,
          //   // fontStyle: FontStyle.italic,
          // ),
          // errorBorder: const OutlineInputBorder(
          //   gapPadding: 10,
          //   borderSide: BorderSide(color: Colors.red, width: 1.0),
          //   borderRadius: BorderRadius.all(Radius.circular(2.0)),
          // ),
          // enabled: true,
          //filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6 * fem),
            borderSide: const BorderSide(color: Color(0xffeaebed)),
          ),
          errorMaxLines: 1,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow, width: 1)),
          border: InputBorder.none,
          suffixIcon: widget.icon),
    );
  }
}
