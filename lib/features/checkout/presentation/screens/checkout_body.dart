import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckoutCubit>().doIntent(GetAllCheckoutIntents());
    });
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Delivery Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Deliver today'),
                    ],
                  ),
                  InkWell(child: Text('Schedule', style: TextStyle(color: Colors.pink))),
                ],
              ),

              const SizedBox(height: 24),

              /// Delivery Address
              const Text(
                'Delivery address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (state.addresses.isLoading)
                const Center(child: CircularProgressIndicator()),

              if (state.addresses.isError)
                Text(
                  state.addresses.error ?? 'Error',
                  style: const TextStyle(color: Colors.red),
                ),

              if (state.addresses.isSuccess)
                Column(
                  children: state.addresses.data!.map((address) {
                    return Card(
                      child: RadioListTile(
                        value: address,
                        groupValue: state.selectedAddress,
                        onChanged: (val) {
                          context.read<CheckoutCubit>().selectAddress(val!);
                        },
                        title: Text(address.username),
                        subtitle: Text('${address.street}, ${address.city}'),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 24),

              /// Payment Method
              const Text(
                'Payment method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              RadioListTile(
                title: const Text('Cash on delivery'),
                value: PaymentMethod.cash,
                groupValue: state.paymentMethod,
                onChanged: (val) =>
                    context.read<CheckoutCubit>().changePaymentMethod(val!),
              ),

              RadioListTile(
                title: const Text('Credit card'),
                value: PaymentMethod.card,
                groupValue: state.paymentMethod,
                onChanged: (val) =>
                    context.read<CheckoutCubit>().changePaymentMethod(val!),
              ),

              const SizedBox(height: 16),

              /// Gift Option
              SwitchListTile(
                title: const Text('It is a gift'),
                value: state.isGift,
                onChanged: (val) =>
                    context.read<CheckoutCubit>().toggleGift(val),
              ),

              const SizedBox(height: 24),

              /// Order Summary
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              const SummaryRow(label: 'Sub Total', value: 250),
              const SummaryRow(label: 'Delivery Fee', value: 30),
              const Divider(),
              const SummaryRow(label: 'Total', value: 280, isBold: true),

              const SizedBox(height: 24),

              /// Place Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: state.isLoading
                      ? null
                      : () => context.read<CheckoutCubit>().doIntent(
                          CashOrderIntent(),
                        ),
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Place order',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),

              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
        ],
      ),
    );
  }
}
