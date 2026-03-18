import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/screens/track_order_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/checkout/domain/models/track_step.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/track_order_state.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/core/ui_helper/color/colors.dart';
import '../../../../generated/locale_keys.g.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  const TrackOrderScreen({super.key, required this.orderId});

  static const _primary = Color(0xFFD81B60);
  static const _textDark = Color(0xFF111827);
  static const _textMuted = Color(0xFF6B7280);
  static const _bgGrey = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TrackOrderCubit>()..doIntent(LoadOrderIntent(orderId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          elevation: 0,
          centerTitle: false,
          leading: const BackButton(color: _textDark),
          title: const Text(
            'Track order',
            style: TextStyle(
              color: _textDark,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          actions: [
            BlocBuilder<TrackOrderCubit, TrackOrderState>(
              builder: (context, state) {
                final activeIndex = state.activeStepIndex;
                final label = activeIndex >= 0
                    ? state.steps[activeIndex].title
                    : '—';
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Chip(
                    label: Text(
                      label,
                      style: const TextStyle(
                        color: _primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: _primary.withOpacity(0.10),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<TrackOrderCubit, TrackOrderState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: _primary),
                );
              }

              if (state.errorMessage != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green.withValues(alpha: 0.1),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green.withValues(alpha: 0.2),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    Text(
                      LocaleKeys.order_success.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _EstimatedArrivalSection(
                            dateText: state.estimatedArrival,
                          ),

                          _DriverCard(
                            name: state.driverName,
                            subtitle: state.driverSubtitle,
                            onCall: () => _launchCaller(state.driverPhone),
                            onWhatsapp: () =>
                                _launchWhatsapp(state.driverWhatsapp),
                          ),

                          const SizedBox(height: 20),
                          _CarIllustration(),
                          const SizedBox(height: 20),
                          _Timeline(steps: state.steps),
                        ],
                      ),
                    ),
                  ),
                  _ShowMapButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrackOrderMapScreen(
                            orderId: orderId,
                            driverId: state.driverId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _launchCaller(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
    final Uri url = Uri(scheme: 'tel', path: cleanPhone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch caller for: $cleanPhone');
    }
  }

  void _launchWhatsapp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
    final String url = "https://wa.me/$cleanPhone";
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp for: $cleanPhone');
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Estimated Arrival
// ─────────────────────────────────────────────────────────────────────────────

class _EstimatedArrivalSection extends StatelessWidget {
  const _EstimatedArrivalSection({required this.dateText});
  final String dateText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estimated arrival',
            style: TextStyle(
              color: TrackOrderScreen._textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            dateText,
            style: const TextStyle(
              color: TrackOrderScreen._textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Driver Card
// ─────────────────────────────────────────────────────────────────────────────

class _DriverCard extends StatelessWidget {
  const _DriverCard({
    required this.name,
    required this.subtitle,
    required this.onCall,
    required this.onWhatsapp,
  });

  final String name;
  final String subtitle;
  final VoidCallback onCall;
  final VoidCallback onWhatsapp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: TrackOrderScreen._bgGrey,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/images/delivery_person.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, color: Color(0xFF9CA3AF), size: 30),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Name + subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: TrackOrderScreen._textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: TrackOrderScreen._textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // Action icons
        _ContactIcon(onTap: onCall, iconPath: 'assets/images/call_icon.svg'),
        const SizedBox(width: 10),
        _ContactIcon(onTap: onWhatsapp, iconPath: 'assets/images/whatsapp.svg'),
      ],
    );
  }
}

class _ContactIcon extends StatelessWidget {
  const _ContactIcon({required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: SvgPicture.asset(iconPath, width: 20, height: 20)),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Car Illustration
// ─────────────────────────────────────────────────────────────────────────────

class _CarIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/car.svg',
        height: 130,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.directions_car_rounded,
          size: 120,
          color: TrackOrderScreen._primary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Timeline
// ─────────────────────────────────────────────────────────────────────────────

class _Timeline extends StatelessWidget {
  const _Timeline({required this.steps});
  final List<TrackStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        return _TimelineItem(step: steps[i], isLast: i == steps.length - 1);
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.step, required this.isLast});

  final TrackStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    const primary = TrackOrderScreen._primary;
    const greyDot = Color(0xFFD1D5DB);
    const greyLine = Color(0xFFE5E7EB);

    final dotColor = (step.isActive || step.isDone) ? primary : greyDot;
    final lineColor = step.isDone ? primary : greyLine;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: dot + line column
        SizedBox(
          width: 28,
          child: Column(
            children: [
              // Dot
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step.isActive
                      ? primary
                      : (step.isDone ? primary : Colors.white),
                  border: Border.all(
                    color: dotColor,
                    width: step.isActive ? 4 : 2,
                  ),
                ),
                child: step.isActive
                    ? Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
              // Connecting line
              if (!isLast)
                Container(
                  width: 2,
                  height: 52,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: lineColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right: title + subtitle
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    color: TrackOrderScreen._textDark,
                    fontSize: 14,
                    fontWeight: step.isActive
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: const TextStyle(
                    color: TrackOrderScreen._textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Show Map Button
// ─────────────────────────────────────────────────────────────────────────────

class _ShowMapButton extends StatelessWidget {
  const _ShowMapButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F8F8),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: TrackOrderScreen._primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Show map',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
