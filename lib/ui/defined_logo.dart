

//verify And Show Specific Logo
import 'package:flutter/material.dart';

definedLogo(logo, {double? width}){
  switch(logo){
    case"elcielodecebreros":
      return  Image.asset(
        'assets/images/logo_elcielodecebreros.png',
        width: width,
        fit: BoxFit.fitWidth,
    );
    case 'cebreterra':
       return  Image.asset(
        'assets/images/banner.png',
        width: width,
        fit: BoxFit.fitWidth,
    );                       
  }
}