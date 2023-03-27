import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:twitter_clone/core/theme/theme.dart';

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
              children: <Widget>[
                AnimatedSmoothIndicator(
                  activeIndex: _current,
                  count: widget._imageLinks.length,
                  effect: ScrollingDotsEffect(
                    offset: 12,
                    dotWidth: 12,
                    dotHeight: 12,
                    radius: 12,
                    dotColor: Pallete.whiteColor.withOpacity(0.4),
                    activeDotColor: Pallete.whiteColor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
