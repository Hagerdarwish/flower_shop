import 'package:flower_shop/app/core/ui_helper/assets/images.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(Assets.imagesFlower),
            const SizedBox(width: 8),
            Text("Flowery", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(width: 10),
            Expanded(child: SearchTextField()),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: AppColors.grey),
            const SizedBox(width: 3),
            Text(
              "Deliver to 2XVP+XC - Sheikh Zayed",
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
