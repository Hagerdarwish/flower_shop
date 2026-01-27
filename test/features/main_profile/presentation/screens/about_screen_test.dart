import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flower_shop/features/main_profile/presentation/screens/about_screen.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'about_screen_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  late MockProfileCubit mockProfileCubit;

  setUp(() => mockProfileCubit = MockProfileCubit());

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<ProfileCubit>(
        create: (context) => mockProfileCubit,
        child: AboutScreen(),
      ),
    );
  }

  testWidgets('loading state ...', (WidgetTester tester) async {
    when(
      mockProfileCubit.state,
    ).thenReturn(ProfileState(about: Resource.loading()));
    when(mockProfileCubit.stream).thenAnswer(
      (_) =>
          Stream<ProfileState>.value(ProfileState(about: Resource.loading())),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(LocaleKeys.aboutUs.tr()), findsOneWidget);
  });

  testWidgets('error state ...', (WidgetTester tester) async {
    when(
      mockProfileCubit.state,
    ).thenReturn(ProfileState(about: Resource.error('Error Msg')));
    when(mockProfileCubit.stream).thenAnswer(
      (_) => Stream<ProfileState>.value(
        ProfileState(about: Resource.error('Error Msg')),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets('success state with empty list...', (WidgetTester tester) async {
    when(
      mockProfileCubit.state,
    ).thenReturn(ProfileState(about: Resource.success([])));
    when(mockProfileCubit.stream).thenAnswer(
      (_) =>
          Stream<ProfileState>.value(ProfileState(about: Resource.success([]))),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(Column), findsNothing);
  });

  testWidgets('success state with data...', (WidgetTester tester) async {
    final data = [
      AboutAndTermsModel(
        section: 'About Us',
        title: {'en': 'Welcome', 'es': 'Bienvenido'},
        content: {'en': 'This is the about us section.'},
        style: null,
        titleStyle: null,
        contentStyle: null,
      ),
    ];

    when(
      mockProfileCubit.state,
    ).thenReturn(ProfileState(about: Resource.success(data)));
    when(mockProfileCubit.stream).thenAnswer(
      (_) => Stream<ProfileState>.value(
        ProfileState(about: Resource.success(data)),
      ),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == 8,
      ),
      findsOneWidget,
    );
    expect(find.text(data[0].title!['en']), findsOneWidget);
  });
}
