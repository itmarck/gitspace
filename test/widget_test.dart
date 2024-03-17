import 'package:flutter_test/flutter_test.dart';

import 'package:gitspace/main.dart';

void main() {
  testWidgets('Add account page has sign in button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Gitspace());

    // Verify that sign in button exists
    expect(find.text('Sign in'), findsOneWidget);
  });
}
