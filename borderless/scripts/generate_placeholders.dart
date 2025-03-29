import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  // Create images directory if it doesn't exist
  Directory('assets/images').createSync(recursive: true);

  // Generate placeholder images
  final images = [
    'headphones.png',
    'watch.png',
    'shoes.png',
  ];

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
    File('assets/images/$imageName').writeAsBytesSync(img.encodePng(image));
  }

  print('Placeholder images generated successfully!');
}
