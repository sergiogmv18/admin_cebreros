import 'package:admin_cebre/model/menu.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeInRight(
                  duration: const Duration(milliseconds: 1500),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/admin.jpg') 
                  ),
                ),
              ],
            ),
            FadeInLeft(
              duration: const Duration(milliseconds: 1500),
              child: Text(
                "Bienvenido al sistema Admin",
               style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              child: Text(
                "Escoja abajo su sistema para administrar",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ), 
            Expanded(
              child: MasonryGridView.builder(
                itemCount: getAllMnenu.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                       Navigator.of(context)..pushNamedAndRemoveUntil(getAllMnenu[index].route, (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FadeInUp(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height:  180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                             
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  getAllMnenu[index].image
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
