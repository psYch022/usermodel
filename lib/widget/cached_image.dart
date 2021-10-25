import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thaartransport/widget/indicatiors.dart';

Widget cachedNetworkImage(String imgUrl) {
  return CachedNetworkImage(
    imageUrl: imgUrl,
    fit: BoxFit.cover,
    height: 200,
    width: 300,
    placeholder: (context, url) => circularProgress(context),
    errorWidget: (context, url, error) => const Center(
      child: Text(
        'Unable to load Image',
        style: TextStyle(fontSize: 10.0),
      ),
    ),
  );
}
