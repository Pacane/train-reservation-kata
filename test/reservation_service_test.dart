import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:train_reservation_kata/kata.dart';
import 'dart:convert';
import 'package:train_reservation_kata/src/seats_picker.dart';

main() {
  int trainId = 123;
  int amountOfSeats = 3;
  Train train = new Train();
  ReservationService sut;
  SeatsPicker seatsPicker = new MockSeatsPicker();
  TrainRepository trainRepository = new MockTrainRepository();
  Booking booking = new Booking();

  setUp(() {
    sut = new ReservationService(seatsPicker, trainRepository);
  });

  group("reserveSeats", () {
    test("delegates to seatsPicker", () {
      when(trainRepository.getTrain(trainId)).thenReturn(new Some(train));
      when(seatsPicker.pickSeats(train, amountOfSeats)).thenReturn(booking);

      var result = sut.reserveSeats(trainId, amountOfSeats);

      expect(result, new Some(booking));
    });

    test("returns None when train is not found", () {
      when(trainRepository.getTrain(trainId)).thenReturn(new None());

      Option<Reservation> reservation =
          sut.reserveSeats(trainId, amountOfSeats);

      expect(reservation is None, isTrue);
    });
  });
}

class MockSeatsPicker extends Mock implements SeatsPicker {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockTrainRepository extends Mock implements TrainRepository {
  noSuchMethod(i) => super.noSuchMethod(i);
}
