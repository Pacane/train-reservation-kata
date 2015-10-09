import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:option/option.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'dart:convert';

class Endpoint {
  final ReservationService reservationService;

  Endpoint(this.reservationService);

  shelf.Response reserveSeats(int trainId, List<String> seats) {
    Option<Reservation> reservation =
        reservationService.reserveSeats(trainId, seats);
    if (reservation is Some<Reservation>) {
      return new shelf.Response(201, body: JSON.encode(reservation.get()));
    } else {
      return new shelf.Response(409);
    }
  }
}

class ReservationService {
  Option<Reservation> reserveSeats(int trainId, List<String> seats) {
    return new Some(new Reservation(1, 1, []));
  }
}

class Reservation {
  final int trainId;
  final int bookingReference;
  final List<String> seats;

  Reservation(this.trainId, this.bookingReference, this.seats);

  Map toJson() {
    Map map = {};
    map['trainId'] = trainId;
    map['bookingReference'] = bookingReference;

    return map;
  }
}

class MockReservationService extends Mock implements ReservationService {
  noSuchMethod(i) => super.noSuchMethod(i);
}

main() {
  Endpoint sut;
  var reservationService;
  final int trainId = 17890;
  final List<String> seats = ["1A", "1B"];

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
      var bookingReference = 12345;
      var reservation = new Reservation(trainId, bookingReference, seats);
      when(reservationService.reserveSeats(trainId, seats))
          .thenReturn(new Some(reservation));
      var expectedBody =
          '{"trainId":$trainId,"bookingReference":$bookingReference}';

      var result = sut.reserveSeats(trainId, seats);

      expect(result.statusCode, 201);
      expect(await result.readAsString(), expectedBody);
    });
  });
}
