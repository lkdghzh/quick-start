import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommonImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const CommonImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
      );
    }

    Widget image =
        imageUrl!.contains('http')
            ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) => Container(color: Colors.grey[300]),
              errorWidget:
                  (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.grey[400]),
                  ),
            )
            : Image.asset(imageUrl!, width: width, height: height, fit: fit);

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}
