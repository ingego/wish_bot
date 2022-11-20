import 'package:firebase_dart/implementation/testing.dart';
import 'package:test/test.dart';
import 'package:wish_bot/api.dart';

void main() {
  test('Api', () async {
    await FirebaseTesting.setup();
    var api = Api();
    await api.initApi();
    await api.getMsg();
  });
}
