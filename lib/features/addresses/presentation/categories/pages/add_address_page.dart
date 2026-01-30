import 'package:flower_shop/app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../app/core/utils/validators_helper.dart';
import '../../../../../app/core/widgets/custom_text_form_field.dart';
import '../widgets/map_grid.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                          // subtle grid look like a map
                          CustomPaint(
                            size: const Size(double.infinity, double.infinity),
                            painter: MapGridPainter(),
                          ),
                          // pin
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
                  CustomTextFormField(
                    controller: _addressCtrl,
                    label: 'Address',
                    hint: 'Enter the address',
                    validator: Validators.validateAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _phoneCtrl,
                    label: 'Phone number',
                    hint: 'Enter the the phone number',
                    validator: Validators.validatePhone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _nameCtrl,
                    label: 'Recipient name',
                    hint: 'Enter the recipient name',
                    validator: Validators.validateRecipientName,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    isEnabled: false,
                    isLoading: false,
                    text: "Save address",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
