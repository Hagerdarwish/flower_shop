import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? price;
  final VoidCallback? onTap;

  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.title,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 160,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            if (price != null)
              Text(
                "${price!} EGP",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 15),
              ),
          ],
        ),
      ),
    );
  }
}
