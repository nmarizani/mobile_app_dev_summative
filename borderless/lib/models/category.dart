import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String? iconAsset;
  final IconData? iconData;
  final List<SubCategory>? subCategories;

  Category({
    required this.id,
    required this.name,
    this.iconAsset,
    this.iconData,
    this.subCategories,
  }) : assert(iconAsset != null || iconData != null,
            'Either iconAsset or iconData must be provided');
}

class SubCategory {
  final String id;
  final String name;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
  });
}
