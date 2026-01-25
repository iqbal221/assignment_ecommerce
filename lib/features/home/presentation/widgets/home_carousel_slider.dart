import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:ecommerce_assignment_module_31/features/home/data/models/slider_model.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key, required this.sliders});

  final List<SliderModel> sliders;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
            autoPlay: true,
          ),
          items: widget.sliders.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(slider.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, selectedIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    height: 16,
                    width: 16,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: i == selectedIndex ? AppColors.themeColor : null,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
