import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/home/presentation/widgets/row_section.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeSection<T> extends StatelessWidget {
  final String title;
  final Resource<List<T>> resource;
  final double height;
  final VoidCallback onTap;
  final Widget Function(BuildContext, T) itemBuilder;

  const HomeSection({
    super.key,
    required this.title,
    required this.resource,
    required this.height,
    required this.onTap,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowSection(title: title, onTap: onTap),
        const SizedBox(height: 10),

        if (resource.isLoading)
          SizedBox(
            height: height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),

        if (resource.isError)
          Container(
            height: height,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.redAccent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
                const SizedBox(height: 8),
                Text(
                  resource.error ?? "Something went wrong",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

        if (resource.isSuccess)
          SizedBox(
            height: height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: resource.data!.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return itemBuilder(context, resource.data![index]);
              },
            ),
          ),
      ],
    );
  }
}
