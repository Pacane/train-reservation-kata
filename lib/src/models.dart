class Reservation {
  final int trainId;
  final int coachId;
  final int bookingReference;
  final List<String> seats;

  Reservation(this.trainId, this.bookingReference, this.coachId, this.seats);

  Reservation.dummy()
      : trainId = 0,
        coachId = 0,
        seats = [],
        bookingReference = 0 {}

  Map toJson() {
    Map map = {};
    map['trainId'] = trainId;
    map['bookingReference'] = bookingReference;
    map['coachId'] = coachId;
    map['seats'] = seats;

    return map;
  }
}
