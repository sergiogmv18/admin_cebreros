import 'package:admin_cebre/style.dart';
import 'package:flutter/material.dart';

class AlertDialogCustom extends StatelessWidget {
 final List<Widget>? actions;
  final String? title;
  final Widget? content;
  const AlertDialogCustom({super.key, this.actions, this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Radio del borde del Card
      ),
      backgroundColor:CustomColors.frontColor,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold) 
      ),
      content: content, 
      scrollable: true,
      actions:actions
    );
  }
}


/*
 * Show message Error to user
 * @author  SGV   - 20230302
 * @version 1.0   - 20230302 - initial release
 * @param   <int> - index    - mumber of specific screen  
 * @return <component> widget BottomNavigationBar
 */
showMessageWarning(BuildContext context, String title)async{
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialogCustom(
        title: 'Atención',
        content:Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        )
      );
    }
  );
}


/*
 * Show message Error to user
 * @author  SGV   - 20230302
 * @version 1.0   - 20230302 - initial release
 * @param   <int> - index    - mumber of specific screen  
 * @return <component> widget BottomNavigationBar
 */
showMessageErrorServer(BuildContext context,{required int errorServer,  required void Function() onPressed})async{
  String title = '';
  switch(errorServer){
    case 500:
      title = 'Problema con conexión, por favor intente mas tarde';
      break;
    case 1: 
      title = 'Usuario o contraseña invalida';
      break;
    default:
      title = 'Por favor intentelo mas tarde';
      break;
  }

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialogCustom(
        title:'Atencion',
        content:Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(onPressed:onPressed, child:const Text('OK'))
        ],
      );
    }
  );
}