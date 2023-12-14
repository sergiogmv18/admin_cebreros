import 'package:admin_cebre/style.dart';
import 'package:flutter/material.dart';

buttonCustom(BuildContext context, { required String title, required void Function()? onPressed,Color? colorFont, Color? bacgroundColor,}){
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(  
      elevation: 6,
      backgroundColor:bacgroundColor ?? CustomColors.pantone5615,// Color de fondo blanco
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Border radius de 20
      ),
    ),
    child:Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color:colorFont ?? CustomColors.frontColor, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}