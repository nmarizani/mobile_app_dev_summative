class Category {
  final String id;
  final String name;
  final String icon;
  final List<SubCategory>? subCategories;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.subCategories,
  });
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
