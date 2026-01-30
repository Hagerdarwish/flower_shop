import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/widgets/saved_address_item.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_cubit.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_states.dart';

class SavedAddressViewBody extends StatelessWidget {
  const SavedAddressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedAddressCubit, SavedAddressStates>(
      builder: (context, state) {
        final resource = state.addressesResource;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(LocaleKeys.savedAddress.tr()),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: () {
                  if (resource.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (resource.isError) {
                    return Center(
                      child: Text(resource.error ?? 'Something went wrong'),
                    );
                  }
                  if (resource.isSuccess && resource.data!.isEmpty) {
                    return const Center(child: Text('No saved addresses'));
                  }
                  if (resource.isSuccess) {
                    final addresses = resource.data!;
                    return ListView.separated(
                      itemCount: addresses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) =>
                          SavedAddressItem(address: addresses[index]),
                    );
                  }
                  return const SizedBox();
                }(),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.addNewAddress.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
