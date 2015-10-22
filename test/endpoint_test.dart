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
  final int coachId = 4324;
  final int amountOfSeats = 5;
  final int bookingReference = 12345;
  final List<int> seats = [11, 12];

  setUp(() {
    reservationService = new MockReservationService();
    sut = new Endpoint(reservationService);
  });

  group("reserveSeats", () {
    test("delegates to ReservationService", () {
      sut.reserveSeats(trainId, amountOfSeats);

      verify(reservationService.reserveSeats(trainId, amountOfSeats));
    });

    test("returns 409 when reservation was not possible", () {
      when(reservationService.reserveSeats(trainId, amountOfSeats))
          .thenReturn(new None());

      var result = sut.reserveSeats(trainId, amountOfSeats);

      expect(result.statusCode, 409);
    });

    test("returns 201 when reservation was created", () async {
      var reservation = new Reservation(trainId, bookingReference, coachId, seats);
      when(reservationService.reserveSeats(trainId, amountOfSeats))
          .thenReturn(new Some(reservation));
      Map expectedResult = {
        'trainId': trainId,
        'bookingReference': bookingReference,
        'coachId': coachId,
        'seats': seats
      };

      var result = sut.reserveSeats(trainId, amountOfSeats);

      var decodedResponse = JSON.decode(await result.readAsString());
      expect(result.statusCode, 201);
      expect(decodedResponse, expectedResult);
    });
  });
}
