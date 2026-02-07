import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../app/config/base_state/base_state.dart';
import '../../../../app/core/network/api_result.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/usecase/clear_all_notifications_usecase.dart';
import '../../domain/usecase/delete_notification_by_id_usecase.dart';
import '../../domain/usecase/get_all_notifications_usecase.dart';
import 'notifications_intent.dart';
import 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final ClearAllNotificationsUseCase _clearAllUseCase;
  final DeleteNotificationUseCase _deleteUseCase;

  NotificationsCubit(
    this._getNotificationsUseCase,
    this._clearAllUseCase,
    this._deleteUseCase,
  ) : super(NotificationsState.initial());

  void doIntent(NotificationsIntent intent) {
    switch (intent) {
      case LoadNotificationsIntent _:
        _loadNotifications();
        break;

      case RefreshNotificationsIntent _:
        _refreshNotifications();
        break;

      case ClearAllNotificationsIntent _:
        _clearAllNotifications();
        break;

      case DeleteNotificationIntent(:final id):
        _deleteNotification(id);
        break;
    }
  }

  Future<void> _loadNotifications({int page = 1, int limit = 40}) async {
    if (state.resource.isLoading) return;

    emit(
      state.copyWith(
        resource: Resource.loading(),
        lastAction: NotificationsAction.none,
      ),
    );

    final result = await _getNotificationsUseCase(page: page, limit: limit);

    if (result is SuccessApiResult<List<NotificationEntity>>) {
      final previous = state.resource.data ?? <NotificationEntity>[];

      final newList = page == 1 ? result.data : [...previous, ...result.data];

      emit(
        state.copyWith(
          resource: Resource.success(newList),
          currentPage: page,
          hasMore: result.data.length == limit,
          lastAction: NotificationsAction.none,
        ),
      );
    }

    if (result is ErrorApiResult<List<NotificationEntity>>) {
      emit(
        state.copyWith(
          resource: Resource.error(result.error),
          lastAction: NotificationsAction.none,
        ),
      );
    }
  }

  Future<void> _refreshNotifications() async {
    await _loadNotifications(page: 1);
  }

  Future<void> _clearAllNotifications() async {
    emit(
      state.copyWith(
        resource: Resource.loading(),
        lastAction: NotificationsAction.none,
      ),
    );

    final result = await _clearAllUseCase();

    if (result is SuccessApiResult<String>) {
      emit(
        state.copyWith(
          resource: Resource.success([]),
          currentPage: 1,
          hasMore: false,
          lastAction: NotificationsAction.cleared,
        ),
      );
    }

    if (result is ErrorApiResult<String>) {
      emit(
        state.copyWith(
          resource: Resource.error(result.error),
          lastAction: NotificationsAction.none,
        ),
      );
    }
  }

  Future<void> _deleteNotification(String id) async {
    final previous = List<NotificationEntity>.from(state.resource.data ?? []);

    final updatedList = previous.where((n) => n.id != id).toList();

    emit(
      state.copyWith(
        resource: Resource.success(updatedList),
        lastAction: NotificationsAction.none,
      ),
    );

    final result = await _deleteUseCase(id);

    if (result is SuccessApiResult<String>) {
      emit(state.copyWith(lastAction: NotificationsAction.deleted));
    }

    // Error → Rollback
    if (result is ErrorApiResult<String>) {
      emit(
        state.copyWith(
          resource: Resource.success(previous),
          lastAction: NotificationsAction.none,
        ),
      );

      emit(state.copyWith(resource: Resource.error(result.error)));
    }
  }
}
