import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/features/orders/api/datasource/orders_remote_datasource_impl.dart';
import 'package:flower_shop/features/orders/data/repos/orders_repo_impl.dart';
import 'package:flower_shop/features/orders/domain/usecase/payment_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';
import 'dart:js' as js;

void main() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://flower.elevateegy.com/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
  );

  final apiClient = ApiClient(dio);
  final datasource = OrdersRemoteDatasourceImpl(apiClient);
  final repo = OrdersRepoImpl(datasource);
  final usecase = PaymentUsecase(repo);

  // Create a dummy AuthStorage instance for testing
  final authStorage =
      AuthStorage(); // <-- make sure it has getToken implemented

  final paymentCubit = PaymentCubit(usecase, authStorage);

  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => paymentCubit,
        child: const PaymentTestScreen(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class PaymentTestScreen extends StatelessWidget {
  const PaymentTestScreen({super.key});

  void _openUrl(String url) {
    js.context.callMethod('open', [url, '_blank']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Cubit Test')),
      body: BlocListener<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state.lastAction == PaymentAction.executing) {
            final res = state.paymentResponse;
            if (res != null &&
                res.isSuccess &&
                res.data?.session?.url != null) {
              _openUrl(res.data!.session!.url!);
            }
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<PaymentCubit, PaymentStates>(
                  builder: (context, state) {
                    String statusText = 'Ready';
                    final res = state.paymentResponse;

                    if (res == null || res.isInitial) {
                      statusText = 'Ready';
                    } else if (res.isLoading) {
                      statusText = 'Loading...';
                    } else if (res.isSuccess) {
                      statusText = 'Success! Opening Stripe...';
                    } else if (res.isError) {
                      statusText = 'Error: ${res.error}';
                    }

                    return Text(
                      'Status: $statusText',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<PaymentCubit, PaymentStates>(
                  builder: (context, state) {
                    final isLoading = state.paymentResponse?.isLoading ?? false;

                    return isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context.read<PaymentCubit>().doIntent(
                                ExecutePaymentIntent(
                                  token:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjk2OGVjZjVlMzY0ZWY2MTQwNDY0MTk5Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3Njk1MjIyMjB9.l7RdSvjVSFXhjp_iYhs8tR_u1B89w1ejE39gwiIpHac',
                                  returnUrl: 'http://localhost:3000',
                                  street: 'Test Street 123',
                                  city: 'Cairo',
                                  phone: '0123456789',
                                  lat: '30.0444',
                                  long: '31.2357',
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('PAY WITH CUBIT'),
                          );
                  },
                ),
                BlocBuilder<PaymentCubit, PaymentStates>(
                  builder: (context, state) {
                    final url =
                        (state.paymentResponse != null &&
                            state.paymentResponse!.isSuccess)
                        ? state.paymentResponse!.data?.session?.url
                        : null;
                    if (url != null) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => _openUrl(url),
                            child: const Text('Open Stripe Manually'),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
