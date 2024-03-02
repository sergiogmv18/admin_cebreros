import 'package:admin_cebre/ui/defined_logo.dart';
import 'package:admin_cebre/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


/*
 * Component of appBar defauld, to be used throughout the app
 * @author  SGV            - 20230216
 * @version 1.0            - 20230216 - initial release
 * @param   <BuildContext> - context - current context  
 * @param   <Color>        - backgroundColor - change bacground color 
 * @return <component> widget AppBar
 */
appBarCustom(BuildContext context,  { Color? backgroundColor, bool showButtonReturn = false, String? route, Object? arguments, String? changeLogo}) {
  return AppBar(
    leading:showButtonReturn ? Container( 
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), 
      child: IconButton(
        onPressed: ()async{
           Navigator.of(context).pushNamedAndRemoveUntil(route!, (route) => false,arguments:arguments);
        },
        icon: const FaIcon(FontAwesomeIcons.circleArrowLeft),
        color: CustomColors.pantone720,
        iconSize: 40,
      ) 
    ): null,
    elevation: 0,
    toolbarHeight: 100,
    backgroundColor: backgroundColor ?? CustomColors.frontColor,
    title: Container(
      child: definedLogo(changeLogo, width: 100),
    ),
    centerTitle: true, 
  );
}
