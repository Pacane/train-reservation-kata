import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:train_reservation_kata/kata.dart';
import 'dart:convert';

class MockReservationService extends Mock implements ReservationService {
  noSuchMethod(i) => super.noSuchMethod(i);
}

main() {
  Endpoint sut;
  ReservationService reservationService;
  final int trainId = 17890;
  final List<String> seats = ["1A", "1B"];
  final int bookingReference = 12345;

  setUp(() {
    reservationService = new MockReservationService();
    sut = new Endpoint(reservationService);
  });

  group("reserveSeats", () {
    test("delegates to ReservationService", () {
      sut.reserveSeats(trainId, seats);

      verify(reservationService.reserveSeats(trainId, seats));
    });

    test("returns 409 when reservation was not possible", () {
      when(reservationService.reserveSeats(trainId, seats))
          .thenReturn(new None());

      var result = sut.reserveSeats(trainId, seats);

      expect(result.statusCode, 409);
    });

    test("returns 201 when reservation was created", () async {
      var reservation = new Reservation(trainId, bookingReference, seats);
      when(reservationService.reserveSeats(trainId, seats))
          .thenReturn(new Some(reservation));
      Map expectedResult = {
        'trainId': trainId,
        'bookingReference': bookingReference
      };

      var result = sut.reserveSeats(trainId, seats);

      var decodedResponse = JSON.decode(await result.readAsString());
      expect(result.statusCode, 201);
      expect(decodedResponse, expectedResult);
    });
  });
}
