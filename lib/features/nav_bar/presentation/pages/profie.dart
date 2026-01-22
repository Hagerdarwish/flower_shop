import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/edit_profile/presentation/pages/editProfileScreen.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/editProfileCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/widgets/EditProfilePageBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          create: (context) => getIt<EditProfileCubit>(),
        ),
        BlocProvider<UploadPhotoCubit>(
          create: (context) => getIt<UploadPhotoCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.editProfile.tr())),
        body: const EditProfilePageBody(),
      ),
    );
  }
}
