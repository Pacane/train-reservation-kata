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
