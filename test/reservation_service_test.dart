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

  setUp(() {
    sut = new ReservationService(seatsPicker, trainRepository);
  });

  test("reservationService delegates to seatsPicker", () {
    when(trainRepository.getTrain(trainId)).thenReturn(train);

    sut.reserveSeats(trainId, amountOfSeats);

    verify(seatsPicker.pickSeats(train, amountOfSeats));
  });
}

class MockSeatsPicker extends Mock implements SeatsPicker {
  noSuchMethod(i) => super.noSuchMethod(i);
}

class MockTrainRepository extends Mock implements TrainRepository {
  noSuchMethod(i) => super.noSuchMethod(i);
}
