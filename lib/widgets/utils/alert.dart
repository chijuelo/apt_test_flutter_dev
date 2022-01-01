import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String menssage, bool isOk, bool back2) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Information'),
          content: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              child: Text(menssage)),
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
                elevation: MaterialStateProperty.all(0.0),
                backgroundColor: MaterialStateProperty.all(
                    isOk ? Colors.lightGreen : Colors.redAccent),
              ),
              child: const Text(
                'Aceptar',
              ),
              onPressed: () {
                Config.flagShowAlert = true;
                Navigator.pop(context);
                if (back2) Navigator.pop(context);
              },
            )
          ],
        );
      });
}
