import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSection extends StatelessWidget {
  final CheckoutState state;
  const AddressSection({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = state.addresses.data!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.delivery_address.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...addresses.map(
          (address) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: state.selectedAddress == address
                    ? Colors.pink
                    : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: RadioListTile(
              value: address,
              groupValue: state.selectedAddress,
              activeColor: Colors.pink,
              onChanged: (val) => context.read<CheckoutCubit>().doIntent(
                SelectAddressIntent(address),
              ),
              title: Text(address.username),
              subtitle: Text('${address.street}, ${address.city}'),
              secondary: const Icon(Icons.edit, size: 18),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.pink),
          label: Text(
            LocaleKeys.add_new.tr(),
            style: const TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
