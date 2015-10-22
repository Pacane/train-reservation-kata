import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:train_reservation_kata/kata.dart';
import 'dart:convert';

main() {
  ReservationService sut;
  final int trainId = 17890;
  final List<String> seats = ["1A", "1B"];
  final int bookingReference = 12345;

  setUp(() {
    sut = new ReservationService();
  });

  group('', () {});
}
