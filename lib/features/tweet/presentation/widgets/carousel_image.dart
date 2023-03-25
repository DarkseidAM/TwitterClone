import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/core/theme/palette.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({
    super.key,
    required List<String> imageLinks,
  }) : _imageLinks = imageLinks;

  final List<String> _imageLinks;

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            CarouselSlider(
              items: widget._imageLinks.map((String image) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (int index, _) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget._imageLinks
                  .asMap()
                  .entries
                  .map((MapEntry<int, String> e) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Pallete.whiteColor
                        .withOpacity(_current == e.key ? 0.9 : 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
