import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/widgets/custom_button.dart';
import 'package:flower_shop/app/core/widgets/custom_text_form_field.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/config/auth_storage/auth_storage.dart';
import '../../../../../app/core/router/route_names.dart';
import '../../../../../app/core/utils/validators_helper.dart';
import '../manager/add_address_cubit.dart';
import '../manager/add_address_events.dart';
import '../manager/add_address_state.dart';
import '../widgets/area_city_widget.dart';
import '../widgets/map_grid.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _recipientCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authStorage = getIt<AuthStorage>();

  @override
  void dispose() {
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _recipientCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddAddressCubit>()..doIntent(LoadLookupsEvent()),
      child: BlocConsumer<AddAddressCubit, AddAddressState>(
        listener: (context, state) {
          final status = state.submitResult.status;

          if (status == Status.success) {
            final msg = LocaleKeys.address_saved_successfully.tr();

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
            context.go(RouteNames.savedAddressesView);
          }

          if (status == Status.error) {
            final msg =
                state.submitResult.error ??
                LocaleKeys.failed_to_save_address.tr();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          }
        },
        builder: (context, state) {
          final isLoading = state.submitResult.status == Status.loading;

          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(),
                    ),
                    Text(LocaleKeys.addNewAddress.tr()),
                  ],
                ),

                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 170,
                            color: Colors.grey.shade200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const AddressMapSection(),
                                const Icon(
                                  Icons.location_pin,
                                  size: 44,
                                  color: Colors.pink,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Address
                        CustomTextFormField(
                          key: const Key('address_field'),
                          controller: _addressCtrl,
                          label: LocaleKeys.address.tr(),
                          hint: LocaleKeys.enter_address.tr(),
                          validator: Validators.validateAddress,
                          onChanged: (v) => context
                              .read<AddAddressCubit>()
                              .doIntent(AddressChangedEvent(v)),
                        ),
                        const SizedBox(height: 20),

                        // Phone
                        CustomTextFormField(
                          key: const Key('phone_field'),
                          controller: _phoneCtrl,
                          label: LocaleKeys.phoneNumber.tr(),
                          hint: LocaleKeys.enter_phone_number.tr(),
                          validator: Validators.validatePhone,
                          onChanged: (v) => context
                              .read<AddAddressCubit>()
                              .doIntent(PhoneChangedEvent(v)),
                        ),
                        const SizedBox(height: 20),

                        // Recipient
                        CustomTextFormField(
                          key: const Key('recipient_field'),
                          controller: _recipientCtrl,
                          label: LocaleKeys.recipient_name.tr(),
                          hint: LocaleKeys.enter_recipient_name.tr(),
                          validator: Validators.validateRecipientName,
                          onChanged: (v) => context
                              .read<AddAddressCubit>()
                              .doIntent(RecipientChangedEvent(v)),
                        ),
                        const SizedBox(height: 20),
                        AreaCityRow(state: state),

                        const SizedBox(height: 20),

                        CustomButton(
                          isEnabled: state.isFormValid && !isLoading,
                          isLoading: isLoading,
                          text: LocaleKeys.save_address.tr(),
                          onPressed: () async {
                            final token = await authStorage.getToken();
                            if (token == null) return;
                            final ok =
                                _formKey.currentState?.validate() ?? false;
                            if (!ok) return;
                            context.read<AddAddressCubit>().doIntent(
                              SubmitAddAddressEvent('Bearer $token'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
