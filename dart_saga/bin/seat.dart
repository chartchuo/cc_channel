import 'dart:typed_data';

import 'package:dart_nats/dart_nats.dart' as nats;

final seats = <int, bool>{
  1: false,
  2: false,
  3: false,
  4: false,
  5: false,
  6: false,
  7: false,
  8: false,
  9: false,
  10: false,
};
var server = nats.Client();

void main() async {
  await server.connect('localhost');
  print('Starting seat server');

  var bookingService = server.sub('seat.book');
  bookingService.stream.listen(bookingHandler);

  var cancelService = server.sub('seat.cancel');
  cancelService.stream.listen(cancelHandler);
}

void bookingHandler(nats.Message request) {
  print('Booking: ${request.data[0]}');

  var sucess = false;
  seats.forEach((seat, booked) {
    if (seat == request.data[0] && !booked) {
      seats[seat] = true;
      // forward
      sucess = true;
      server.pub('coupon.redeem', request.data, replyTo: request.replyTo);
      return;
    }
  });
  if (!sucess) {
    print('Error');
    request.respond(Uint8List.fromList([0, 0]));
  }
  print(seats);
}

void cancelHandler(nats.Message request) {
  print('Canceling: ${request.data[0]}');

  seats.forEach((seat, booked) {
    if (seat == request.data[0]) {
      seats[seat] = false;
    }
  });

  request.respond(Uint8List.fromList([0, 0]));
  print(seats);
}
