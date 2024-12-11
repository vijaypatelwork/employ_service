import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.index,
    required this.press,
    required this.grd,
  }) : super(key: key);
  final Icon icon;
  final Gradient grd;
  final int index;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        visualDensity: VisualDensity(horizontal: 3.0, vertical: 3.0),
      ),
      child: SingleChildScrollView(
        // Add scrolling for overflow
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjusts the column to its content
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
                gradient: grd,
              ),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 46, 49),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
