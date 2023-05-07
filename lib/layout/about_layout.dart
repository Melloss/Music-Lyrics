import 'package:flutter/material.dart';

class AboutLayout extends StatefulWidget {
  const AboutLayout({super.key});

  @override
  State<AboutLayout> createState() => _AboutLayoutState();
}

class _AboutLayoutState extends State<AboutLayout> {
  int selectedItemIndex = 0;
  List<ListTile> items = [
    const ListTile(
      leading: Icon(
        Icons.person_pin,
        size: 50,
      ),
      title: Text('Developer'),
      subtitle: Text('Mikiyas Tekalign (Melloss)'),
    ),
    const ListTile(
      leading: Icon(
        Icons.language_rounded,
        size: 50,
      ),
      title: Text('Programming Language'),
      subtitle: Text('Dart Flutter'),
    ),
    const ListTile(
      leading: Icon(Icons.control_camera, size: 50),
      title: Text('State Manager'),
      subtitle: Text('GetX'),
    ),
    const ListTile(
      leading: Icon(Icons.compass_calibration_rounded, size: 50),
      title: Text('Dependencies'),
      subtitle: Text('get, http, firebase_core'),
    ),
    const ListTile(
      leading: Icon(Icons.help, size: 50),
      title: Text('Why Flutter'),
      subtitle: Text(
          'currently, I\'m not comfortable on React\n,but i promise i will if you give me the chance!\n\n Thank You for your time '),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 500,
      child: ListWheelScrollView(
        itemExtent: 85,
        magnification: 1.5,
        useMagnifier: true,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 2,
        squeeze: 0.8,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedItemIndex = index;
          });
        },
        children: items,
      ),
    );
  }
}
