import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Employee Suvidha Portal',
          style: TextStyle(
            color: Color(0xFFE4DAF4),
          ),
        ),
        background: Padding(
          padding: const EdgeInsets.all(60.0),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
            ),
            items: [
              'assets/images/banner_1.png',
              'assets/images/banner_2.png',
              'assets/images/banner_3.png',
            ].map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      url,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
