import 'dart:io' as io;
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/auth/presentation/change_password/pages/change_password_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flower_shop/app/core/values/app_endpoint_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/auth/presentation/signup/widgets/text_form_field_widget.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_cubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_intent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/upload_photo_state.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_cubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_intent.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/edit_profile_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

class EditProfilePageBody extends StatefulWidget {
  final ProfileUserModel? user;
  const EditProfilePageBody({super.key, this.user});

  @override
  State<EditProfilePageBody> createState() => _EditProfilePageBodyState();
}

class _EditProfilePageBodyState extends State<EditProfilePageBody> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  final authStorage = getIt<AuthStorage>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
      text: widget.user?.firstName ?? 'ali',
    );
    lastNameController = TextEditingController(
      text: widget.user?.lastName ?? 'besar',
    );
    emailController = TextEditingController(
      text: widget.user?.email ?? 'alibesar@gmail.com',
    );
    phoneController = TextEditingController(
      text: widget.user?.phone ?? '+201557689713',
    );
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.user != null) return;
    final user = await authStorage.getUser();
    if (user != null) {
      firstNameController.text = user.firstName ?? 'ali';
      lastNameController.text = user.lastName ?? 'besar';
      emailController.text = user.email ?? 'alibesar@gmail.com';
      phoneController.text = user.phone ?? '+201557689713';
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();
    final photoCubit = context.read<UploadPhotoCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfileCubit, EditProfileStates>(
          listener: (context, state) {
            final resource = state.editProfileResource;
            if (resource.status == Status.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Profile updated successfully!",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.pink,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (resource.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    resource.message ?? "Something went wrong",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
        BlocListener<UploadPhotoCubit, UploadPhotoState>(
          listener: (context, state) {
            final resource = state.uploadPhotoResource;
            if (resource.status == Status.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Photo uploaded successfully!",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.pink,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (resource.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    resource.message ?? "Photo upload failed",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder<UserModel?>(
              future: authStorage.getUser(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                return BlocBuilder<UploadPhotoCubit, UploadPhotoState>(
                  builder: (context, state) {
                    ImageProvider avatarImage;
                    if (state.selectedPhoto != null) {
                      if (kIsWeb) {
                        avatarImage = NetworkImage(state.selectedPhoto!.path);
                      } else {
                        avatarImage = FileImage(
                          io.File(state.selectedPhoto!.path),
                        );
                      }
                    } else {
                      String? photoUrl =
                          state.uploadPhotoResource.data?.user?.photo ??
                          user?.photo ??
                          widget.user?.photo;
                      if (photoUrl != null) {
                        if (!photoUrl.startsWith('http')) {
                          photoUrl =
                              "${AppEndpointString.baseUrl.replaceAll('api/v1/', '')}${photoUrl.replaceAll('\\', '/')}";
                        }
                        avatarImage = NetworkImage(photoUrl);
                      } else {
                        avatarImage = const AssetImage(
                          'assets/images/filter.png',
                        );
                      }
                    }

                    return Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: avatarImage,
                            ),
                            if (state.uploadPhotoResource.status ==
                                Status.loading)
                              const CircularProgressIndicator(
                                color: AppColors.pink,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              photoCubit.doIntent(
                                SelectPhotoIntent(pickedFile),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: AppColors.pink,
                          ),
                          label: const Text(
                            "Change Photo",
                            style: TextStyle(color: AppColors.pink),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    label: 'First name',
                    hint: 'First name',
                    controller: firstNameController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormFieldWidget(
                    label: 'Last name',
                    hint: 'Last name',
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: 'Email',
              hint: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: 'Phone number',
              hint: 'Phone number',
              controller: phoneController,
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                context.push(RouteNames.changePassword);
              },
              child: TextFormFieldWidget(
                enabled: false,
                label: 'password',
                hint: '*********',
                suffixIcon: Text(
                  "Change     ",
                  style: TextStyle(color: AppColors.pink),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final token = await authStorage.getToken();
                  if (token == null) return;
                  if (photoCubit.state.selectedPhoto != null) {
                    photoCubit.doIntent(
                      UploadSelectedPhotoIntent('Bearer $token'),
                    );
                  }
                  editCubit.doIntent(
                    PerformEditProfile(
                      token: 'Bearer $token',
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    ),
                  );
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
