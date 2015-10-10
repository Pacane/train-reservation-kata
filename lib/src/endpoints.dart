import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:option/option.dart';
import 'services.dart';
import 'models.dart';

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
