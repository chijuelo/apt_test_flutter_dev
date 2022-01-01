import 'package:apt_test_flutter_dev/shared/colors.dart';
import 'package:apt_test_flutter_dev/shared/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

enum sort { asc, desc, noSort }

class _CategoriesPageState extends State<CategoriesPage> {
  late Size _size;
  sort _sort = sort.noSort;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * 0.05,
        vertical: _size.height * 0.08,
      ),
      child: Card(
        color: kScaffoldBackground,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _categories(),
              _sorts(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context, _sort);
                    },
                    backgroundColor: Colors.lightGreen,
                    label: const Text('Acept'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    int _index = 0;
    List<Widget> _column1 = [];
    List<Widget> _column2 = [];

    if (_sort != sort.noSort &&
        !Config.categories.containsValue(true) &&
        Config.onLine) {
      Config.categories['Name'] = true;
    }

    Config.categories.forEach((key, value) {
      switch (_index % 2) {
        case 0:
          _column1.add(
            ListTile(
              title: Text(
                key,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                setState(
                  () {
                    Config.categories[key] = !Config.categories[key]!;
                  },
                );
              },
              trailing: CupertinoSwitch(
                activeColor: Colors.lightGreen,
                value: value,
                onChanged: (v) {
                  setState(
                    () {
                      Config.categories[key] = v;
                    },
                  );
                },
              ),
            ),
          );
          break;
        default:
          _column2.add(
            ListTile(
              title: Text(
                key,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                setState(
                  () {
                    Config.categories[key] = !Config.categories[key]!;
                  },
                );
              },
              trailing: CupertinoSwitch(
                activeColor: Colors.lightGreen,
                value: value,
                onChanged: (v) {
                  setState(
                    () {
                      Config.categories[key] = v;
                    },
                  );
                },
              ),
            ),
          );
      }
      _index++;
    });

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'Categories:',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen),
          ),
        ),
        Row(
          children: [
            Expanded(child: Column(children: _column1)),
            Expanded(
              child: Column(
                children: _column2,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _sorts() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Sort:',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<sort>(
                title: const Text(
                  'Asc',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                activeColor: Colors.lightGreen,
                value: sort.asc,
                groupValue: _sort,
                onChanged: (sort? value) {
                  setState(() {
                    _sort = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<sort>(
                title: const Text(
                  'Desc',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                activeColor: Colors.lightGreen,
                value: sort.desc,
                groupValue: _sort,
                onChanged: (sort? value) {
                  setState(() {
                    _sort = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
