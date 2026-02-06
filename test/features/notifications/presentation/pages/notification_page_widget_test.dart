import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/widgets/empty_list.dart';
import 'package:flower_shop/app/core/widgets/shimmer_list.dart';
import 'package:flower_shop/features/notifications/presentation/pages/notification_page.dart';
import 'package:flower_shop/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_state.dart';
import 'package:flower_shop/features/notifications/presentation/manager/notifications_intent.dart';
import 'package:flower_shop/features/notifications/domain/entity/notification_entity.dart';

import 'notification_page_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotificationsCubit>()])
void main() {
  late MockNotificationsCubit mockCubit;

  final fakeNotifications = [
    NotificationEntity(id: '1', title: 'Title1', body: 'Body1'),
    NotificationEntity(id: '2', title: 'Title2', body: 'Body2'),
  ];

  setUp(() {
    mockCubit = MockNotificationsCubit();

    // Default initial state
    when(mockCubit.state).thenReturn(NotificationsState.initial());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<NotificationsCubit>.value(
        value: mockCubit,
        child: const NotificationsPage(),
      ),
    );
  }

  testWidgets('shows shimmer when loading', (tester) async {
    when(mockCubit.state).thenReturn(
      NotificationsState.initial().copyWith(resource: Resource.loading()),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ShimmerList), findsOneWidget);
  });

  testWidgets('shows list of notifications when success', (tester) async {
    when(mockCubit.state).thenReturn(
      NotificationsState.initial().copyWith(
        resource: Resource.success(fakeNotifications),
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Title1'), findsOneWidget);
    expect(find.text('Title2'), findsOneWidget);
    expect(find.byType(NotificationTile), findsNWidgets(2));
  });

  // testWidgets('shows empty list widget when success but no data', (tester) async {
  //   when(mockCubit.state).thenReturn(
  //     NotificationsState.initial().copyWith(
  //       resource: Resource.success([]),
  //     ),
  //   );
  //
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   expect(find.byType(EmptyList), findsOneWidget);
  // });
  //
  // testWidgets('tapping clear all button calls cubit', (tester) async {
  //   when(mockCubit.state).thenReturn(
  //     NotificationsState.initial().copyWith(
  //       resource: Resource.success(fakeNotifications),
  //     ),
  //   );
  //
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   final clearButton = find.text('Clear All'); // or localized text
  //   expect(clearButton, findsOneWidget);
  //
  //   await tester.tap(clearButton);
  //   await tester.pump();
  //
  //   verify(mockCubit.doIntent(ClearAllNotificationsIntent())).called(1);
  // });
  //
  // testWidgets('swipe to delete calls cubit', (tester) async {
  //   when(mockCubit.state).thenReturn(
  //     NotificationsState.initial().copyWith(
  //       resource: Resource.success(fakeNotifications),
  //     ),
  //   );
  //
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   final firstTile = find.text('Title1');
  //   expect(firstTile, findsOneWidget);
  //
  //   await tester.drag(firstTile, const Offset(-500, 0));
  //   await tester.pumpAndSettle();
  //
  //   verify(mockCubit.doIntent(DeleteNotificationIntent('1'))).called(1);
  // });
}
