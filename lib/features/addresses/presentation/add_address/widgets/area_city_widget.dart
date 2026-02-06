import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/core/utils/validators_helper.dart';
import '../../../domain/models/city_item.dart';
import '../../../domain/models/area_item.dart';
import '../manager/add_address_cubit.dart';
import '../manager/add_address_events.dart';
import '../manager/add_address_state.dart';

class AreaCityRow extends StatelessWidget {
  final AddAddressState state;

  AreaCityRow({required this.state});

  @override
  Widget build(BuildContext context) {
    final areaReady = state.area.isNotEmpty;
    final citiesReady = state.cities.isNotEmpty;
    final isCitySelected = state.selectedCity != null;
    final areas = state.area;

    final safeSelectedArea = areas.any((a) => a.id == state.selectedArea?.id)
        ? state.selectedArea
        : null;

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<CityItem>(
              isExpanded: true,
              value: citiesReady ? state.selectedCity : null,
              items: citiesReady
                  ? state.cities
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(
                              c.nameEn,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList()
                  : const [],
              onChanged: citiesReady
                  ? (v) {
                      if (v != null) {
                        context.read<AddAddressCubit>().doIntent(
                          CitySelectedEvent(v),
                        );
                      }
                    }
                  : null,
              decoration: const InputDecoration(labelText: 'City'),
              validator: Validators.validateCity,
            ),
          ),

          const SizedBox(width: 20),
          Expanded(
            child: DropdownButtonFormField<AreaItem>(
              isExpanded: true,
              value: safeSelectedArea,
              items: areaReady
                  ? state.area
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(
                              c.nameEn,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList()
                  : const [],
              onChanged: areaReady && isCitySelected
                  ? (v) {
                      if (v != null) {
                        context.read<AddAddressCubit>().doIntent(
                          AreaSelectedEvent(v),
                        );
                      }
                    }
                  : null,
              decoration: const InputDecoration(labelText: 'Area'),
              validator: Validators.validateArea,
            ),
          ),
        ],
      ),
    );
  }
}
