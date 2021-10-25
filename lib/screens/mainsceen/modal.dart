// ignore: file_names
// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/truck_1.png',
    title: 'Live Transport Market',
    description:
        'Book Trucks, Trailers , Containers & Tankers from Live market and find best deals.',
  ),
  Slide(
    imageUrl: 'assets/images/truck_2.png',
    title: 'Live Transport Market',
    description:
        'Book Trucks, Trailers , Containers & Tankers from Live market and find best deals.',
  ),
  Slide(
    imageUrl: 'assets/images/truck_3.png',
    title: 'Design Interactive App UI',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/truck_4.png',
    title: 'It\'s Just the Beginning',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
  Slide(
    imageUrl: 'assets/images/banner_1.png',
    title: 'It\'s Just the Beginning',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];
