import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

buttonMenu(BuildContext context, {String? title, String? route, Object? arguments, double? width}){
    return FadeInUp(
      child:ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(route!, (route) => false, arguments:arguments);
        },
        style: ElevatedButton.styleFrom(  
          elevation: 6,
          backgroundColor: CustomColors.pantone5615,// Color de fondo blanco
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Border radius de 20
          ),
        ),
        child:Container(
          width: width,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Text(
            title!,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: CustomColors.frontColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }