import '../../../../app/config/base_state/base_state.dart';
import '../../domain/entity/notification_entity.dart';

enum NotificationsAction { none, deleted, cleared }

class NotificationsState {
  final Resource<List<NotificationEntity>> resource;
  final int currentPage;
  final bool hasMore;
  final NotificationsAction lastAction;

  const NotificationsState({
    required this.resource,
    this.currentPage = 1,
    this.hasMore = true,
    this.lastAction = NotificationsAction.none,
  });

  factory NotificationsState.initial() => NotificationsState(
    resource: Resource.initial(),
    currentPage: 1,
    hasMore: true,
    lastAction: NotificationsAction.none,
  );

  NotificationsState copyWith({
    Resource<List<NotificationEntity>>? resource,
    int? currentPage,
    bool? hasMore,
    NotificationsAction? lastAction,
  }) {
    return NotificationsState(
      resource: resource ?? this.resource,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      lastAction: lastAction ?? this.lastAction,
    );
  }
}
