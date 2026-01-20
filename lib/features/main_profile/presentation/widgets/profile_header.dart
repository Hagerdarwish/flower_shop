// lib/features/main_profile/presentation/widgets/profile_header.dart
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileUserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = _getDisplayName();
    final email = user.email ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Avatar without image - using initials
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _getInitials(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flowery',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                if (displayName.isNotEmpty || email.isNotEmpty)
                  Text(
                    displayName.isNotEmpty ? '$displayName / $email' : email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName() {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    final name = '$firstName $lastName'.trim();

    // If no name, use email username part
    if (name.isEmpty && user.email != null) {
      return user.email!.split('@').first;
    }

    return name;
  }

  String _getInitials() {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    } else if (firstName.isNotEmpty) {
      return firstName[0].toUpperCase();
    } else if (lastName.isNotEmpty) {
      return lastName[0].toUpperCase();
    } else if (user.email != null && user.email!.isNotEmpty) {
      return user.email![0].toUpperCase();
    }

    return 'U'; // Default for User
  }
}
