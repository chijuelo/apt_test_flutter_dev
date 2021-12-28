import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String label;
  final int? cantNewMarket;
  const CustomAppBar({Key? key, required this.label, this.cantNewMarket})
      : super(key: key);

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size(0, 55);
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(widget.label),
      actions: [
        widget.cantNewMarket != null && widget.cantNewMarket! > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Center(
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: FaIcon(
                            FontAwesomeIcons.bell,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: Colors.lightGreen,
                                ),
                                child: Text(
                                  widget.cantNewMarket!.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/market'),
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GestureDetector(
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed('/market'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GestureDetector(
            child: const Center(
              child: FaIcon(
                FontAwesomeIcons.userCog,
                color: Colors.white,
              ),
            ),
            onTap: () => Navigator.of(context).pushNamed('/userSettings'),
          ),
        ),
      ],
    );
  }
}
