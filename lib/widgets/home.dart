import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
          elevation: 0.0,
          toolbarHeight: 60,
          leading: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () => _scaffoldKey.currentState?.openDrawer()),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(80))),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.black,
                      // child: const FadeInImage(
                      //   image: AssetImage('assets/images/avatar.png'),
                      //   placeholder: AssetImage('assets/images/avatar.png'),
                      //   fadeInDuration: Duration(milliseconds: 200),
                      //   fit: BoxFit.fill,
                      // )
                    )),
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
        backgroundColor: kScaffoldBackground,
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            onPressed: () {}, child: const Icon(Icons.add)),
        body: ListView(padding: const EdgeInsets.all(15.0), children: [
          Row(
            children: const [
              Text(
                'Hola, ',
                style: TextStyle(fontSize: 30, fontFamily: 'Roboto'),
              ),
              Text(
                'Julio',
                style: TextStyle(
                    fontSize: 30, fontFamily: 'Roboto', color: Colors.blue),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: const [
              Text('Qué quieres buscar...?',
                  style: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: const [],
          ),
          const SizedBox(height: 10),
        ]));
  }
}
