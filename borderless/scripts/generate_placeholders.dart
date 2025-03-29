import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  // Create directories if they don't exist
  Directory('assets/images').createSync(recursive: true);
  Directory('assets/icons').createSync(recursive: true);
  Directory('assets/images/subcategories').createSync(recursive: true);

  // Generate placeholder images
  final images = [
    // Existing images
    'logo.png',
    'banner.png',
    'banner2.png',
    'apple_watch.png',
    'backpack.png',
    'earbuds.png',
    'handbag.png',
    'headphones.png',
    'watch.png',
    'shoes.png',
    'headphones1.png',
    'headphones2.png',
    'headphones3.png',
    'headphones4.png',
    'headphones5.png',
    'headphones6.png',
    'watch1.png',
    'watch1_2.png',
    'watch1_3.png',
    'nike_shoes.png',
    'glasses.png',
    'empty_orders.png',
    'empty_cart.png',
    'empty_wishlist.png',
    'onboarding1.png',
    'onboarding2.png',
    'onboarding3.png',
    'paypal.png',
    'google_pay.png',
    'visa.png',
    'mastercard.png',
    'pk_flag.png',
    'order_success.png',
    'lock_success.png',
    'headphone1.png',
  ];

  final subcategoryImages = [
    'laptops.png',
    'mobile_phones.png',
    'headphones.png',
    'smart_watches.png',
    'mobile_cases.png',
    'monitors.png',
  ];

  final productImages = [
    'headphones.png',
    'smartwatch.png',
    'coffee_table.png',
    'tool_set.png',
    'vase.png',
  ];

  final icons = [
    'electronics_tv.png',
    'electrical.png',
    'google.png',
    'electronics.png',
    'fashion.png',
    'furniture.png',
    'industrial.png',
    'home_decor.png',
    'construction.png',
    'fabrication.png',
  ];

  // Generate main images
  for (final imageName in images) {
    final image = img.Image(width: 200, height: 200);
    img.fill(image, color: img.ColorRgb8(200, 200, 200));

    // Add some text to identify the image
    img.drawString(
      image,
      imageName.split('.')[0],
      font: img.arial24,
      x: 50,
      y: 100,
    );

    // Save the image
    final file = File('assets/images/$imageName');
    file.writeAsBytesSync(img.encodePng(image));
    print('Generated: ${file.path}');
  }

  // Generate subcategory images
  for (final imageName in subcategoryImages) {
    final image = img.Image(width: 400, height: 300);
    img.fill(image, color: img.ColorRgb8(180, 180, 180));

    // Add some text to identify the image
    img.drawString(
      image,
      imageName.split('.')[0],
      font: img.arial24,
      x: 100,
      y: 150,
    );

    // Save the image
    final file = File('assets/images/subcategories/$imageName');
    file.writeAsBytesSync(img.encodePng(image));
    print('Generated: ${file.path}');
  }

  // Generate product images
  for (final imageName in productImages) {
    final image = img.Image(width: 300, height: 300);
    img.fill(image, color: img.ColorRgb8(160, 160, 160));

    // Add some text to identify the image
    img.drawString(
      image,
      imageName.split('.')[0],
      font: img.arial24,
      x: 75,
      y: 150,
    );

    // Save the image
    final file = File('assets/images/$imageName');
    file.writeAsBytesSync(img.encodePng(image));
    print('Generated: ${file.path}');
  }

  // Generate icons
  for (final iconName in icons) {
    final image = img.Image(width: 100, height: 100);
    img.fill(image, color: img.ColorRgb8(100, 100, 100));

    // Add some text to identify the icon
    img.drawString(
      image,
      iconName.split('.')[0],
      font: img.arial24,
      x: 10,
      y: 50,
    );

    // Save the icon
    final file = File('assets/icons/$iconName');
    file.writeAsBytesSync(img.encodePng(image));
    print('Generated: ${file.path}');
  }

  print('All placeholder images and icons generated successfully!');
}
