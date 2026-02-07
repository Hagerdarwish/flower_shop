sealed class NotificationsIntent {
  const NotificationsIntent();

  static const load = LoadNotificationsIntent();
  static const refresh = RefreshNotificationsIntent();
  static const clearAll = ClearAllNotificationsIntent();
  static DeleteNotificationIntent deleteNotification(String id) =>
      DeleteNotificationIntent(id);
}

class LoadNotificationsIntent extends NotificationsIntent {
  const LoadNotificationsIntent();
}

class RefreshNotificationsIntent extends NotificationsIntent {
  const RefreshNotificationsIntent();
}

class ClearAllNotificationsIntent extends NotificationsIntent {
  const ClearAllNotificationsIntent();
}

class DeleteNotificationIntent extends NotificationsIntent {
  final String id;
  DeleteNotificationIntent(this.id);
}
