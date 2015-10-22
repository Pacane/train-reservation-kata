import 'package:option/option.dart';
import 'models.dart';
import 'seats_picker.dart';

class ReservationService {
  SeatsPicker seatsPicker;
  TrainRepository trainRepository;

  ReservationService(this.seatsPicker, this.trainRepository);

  Option<Reservation> reserveSeats(int trainId, int amountOfSeats) {
    Option<Train> train = trainRepository.getTrain(trainId);

    if(train is None) {
      return new None();
    }

    seatsPicker.pickSeats(train.get(), amountOfSeats);

    return new Some(new Reservation.dummy());
  }
}

class TrainRepository {
  Option<Train> getTrain(int trainId) {
    return new Some(new Train());
  }
}
