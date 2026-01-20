// lib/features/main_profile/presentation/cubit/profile_intent.dart
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_menu_item_type.dart';

sealed class ProfileIntent {
  const ProfileIntent();
}

// Load profile intents
class LoadProfileIntent extends ProfileIntent {
  const LoadProfileIntent();
}

class RefreshProfileIntent extends ProfileIntent {
  const RefreshProfileIntent();
}

// Logout intents
class LogoutIntent extends ProfileIntent {
  const LogoutIntent();
}

class ConfirmLogoutIntent extends ProfileIntent {
  const ConfirmLogoutIntent();
}

class CancelLogoutIntent extends ProfileIntent {
  const CancelLogoutIntent();
}

// Language intents
class ChangeLanguageIntent extends ProfileIntent {
  final String languageCode;

  const ChangeLanguageIntent(this.languageCode);
}

// Notification intents
class ToggleNotificationIntent extends ProfileIntent {
  final bool enable;

  const ToggleNotificationIntent(this.enable);
}

// Navigation intents (now using menu item type)
class NavigateToMenuItemIntent extends ProfileIntent {
  final ProfileMenuItemType itemType;

  const NavigateToMenuItemIntent(this.itemType);
}

// Profile update intents
class UpdateProfileIntent extends ProfileIntent {
  final Map<String, dynamic> updates;

  const UpdateProfileIntent(this.updates);
}

// Avatar intents
class UploadAvatarIntent extends ProfileIntent {
  final String imagePath;

  const UploadAvatarIntent(this.imagePath);
}

class RemoveAvatarIntent extends ProfileIntent {
  const RemoveAvatarIntent();
}

// Error handling intents
class ShowErrorIntent extends ProfileIntent {
  final String message;

  const ShowErrorIntent(this.message);
}

class DismissErrorIntent extends ProfileIntent {
  const DismissErrorIntent();
}
