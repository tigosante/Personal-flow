import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_flow/app/appController.dart';
import 'package:personal_flow/app/AppModule.dart';

void main() {
  initModule(AppModule());
  AppController app;

  setUp(() {
    app = AppModule.to.get<AppController>();
  });

  group('AppController Test', () {
    test("First Test", () {
      expect(app, isInstanceOf<AppController>());
    });

    test("Set Value", () {});
  });
}
