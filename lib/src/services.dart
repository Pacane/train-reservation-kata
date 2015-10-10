import 'package:option/option.dart';
import 'models.dart';

class ReservationService {
  Option<Reservation> reserveSeats(int trainId, List<String> seats) {
    return new Some(new Reservation(1, 1, []));
  }
}
