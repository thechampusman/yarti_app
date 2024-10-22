import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _imageList = [
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
    'assets/banner.jpg',
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < _imageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.15, // Adjust height as needed
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _imageList.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20), // Rounded corners
                child: Image.asset(
                  _imageList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Positioned(
            bottom: 10, // Adjust the position of the dots
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _imageList.length,
                effect: WormEffect(
                  // You can customize this effect
                  dotColor: Colors.black,
                  activeDotColor: Colors.green,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
