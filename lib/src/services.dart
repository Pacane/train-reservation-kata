import 'package:option/option.dart';
import 'models.dart';

class ReservationService {
  Option<Reservation> reserveSeats(int trainId, int amountOfSeats) {
    return new Some(new Reservation(1, 1, []));
  }
}
