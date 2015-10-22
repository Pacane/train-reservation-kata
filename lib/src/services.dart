import 'package:option/option.dart';
import 'models.dart';
import 'seats_picker.dart';

class ReservationService {
  SeatsPicker seatsPicker;
  TrainRepository trainRepository;

  ReservationService(this.seatsPicker, this.trainRepository);

  Option<Reservation> reserveSeats(int trainId, int amountOfSeats) {
    Train train = trainRepository.getTrain(trainId);

    seatsPicker.pickSeats(train, amountOfSeats);

    return new Some(new Reservation.dummy());
  }
}

class TrainRepository {
  Train getTrain(int trainId) {
    return new Train();
  }
}
