import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_cubit.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_intent.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(context.read()), // Assuming you have access to dependencies
      child: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          final signupState = state.signupState;

          return Scaffold(
            appBar: AppBar(title: const Text('Profile'), centerTitle: true),
            body: _buildProfileContent(context, signupState),
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, SignupState? signupState) {
    if (signupState == null || signupState.data == null) {
      return _buildNoProfileData();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          _buildProfileHeader(signupState.data!),
          const SizedBox(height: 30),

          // Personal Information Section
          _buildSectionTitle('Personal Information'),
          _buildInfoCard(signupState.data!),

          const SizedBox(height: 20),

          // Actions
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildNoProfileData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'No Profile Data',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Text(
            'Complete your registration to view profile',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(SignupModel data) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Text(
            '${data.user!.firstName} ${data.user!.lastName}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            data.user!.email!,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard(SignupModel data) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('First Name', data.user!.firstName!),
            const Divider(),
            _buildInfoRow('Last Name', data.user!.lastName!),
            const Divider(),
            _buildInfoRow('Email', data.user!.email!),
            const Divider(),
            _buildInfoRow('Phone', data.user!.phone!),
            const Divider(),
            _buildInfoRow('Gender', data.user!.gender!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to edit profile screen
              // You can implement this based on your navigation setup
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Handle logout
              // Navigate to login screen
              context.read<AuthCubit>().doUiIntent(NavigateToLoginEvent());
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
