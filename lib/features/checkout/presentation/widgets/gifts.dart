import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class GiftSection extends StatelessWidget {
  final bool isGift;
  final Function(bool) onToggle;
  final Function(String) onNameChanged;
  final Function(String) onPhoneChanged;
  final TextEditingController giftNameController;
  final TextEditingController giftPhoneController;

  const GiftSection({
    required this.isGift,
    required this.onToggle,
    required this.onNameChanged,
    required this.onPhoneChanged,
    required this.giftNameController,
    required this.giftPhoneController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: isGift,
          activeColor: Colors.pink,
          onChanged: onToggle,
          title: Text(LocaleKeys.it_is_a_gift.tr()),
        ),
        if (isGift) ...[
          const SizedBox(height: 8),
          TextField(
            controller: giftNameController,
            onChanged: onNameChanged,
            decoration: InputDecoration(
              labelText: LocaleKeys.recipient_name.tr(),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: giftPhoneController,
            onChanged: onPhoneChanged,
            decoration: InputDecoration(
              labelText: LocaleKeys.recipient_phone.tr(),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ],
    );
  }
}
