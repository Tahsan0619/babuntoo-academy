import 'package:flutter_test/flutter_test.dart';
import 'package:BabunToo_Academy/main.dart';

void main() {
  testWidgets('App loads and shows HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const BabuntooApp()); // Use the actual root widget class name
    expect(find.text('Babuntoo Academy'), findsOneWidget); // Use the text that appears on your HomePage's AppBar/title
  });
}
